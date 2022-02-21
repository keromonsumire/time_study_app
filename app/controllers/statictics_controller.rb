class StaticticsController < ApplicationController
  require 'date'
  before_action :setup

  def setup
    @user = current_user
    @starts = Start.where(user_id:@user.id).order("time DESC").paginate(page: params[:page])
    @ends = End.where(user_id:@user.id)
    @total = 0
    @data = []
  end

  def statictics
    if (session[:up] == nil) || (session[:up] % 7 != Time.current.wday) || session[:up].negative?
      @up = 0
    else
      @up = session[:up]
    end

    if (Time.now.wday != 0) && (@up == 0)
      1.upto(7 - Time.current.wday) do |i|
        @data.push([Time.current.since(i.days).to_date, 0])
      end
    end

    @up.upto(@up + 7) do |i|
      if @ends.where(time: i.day.ago.all_day) 
        @data.unshift([Time.current.ago(i.days).to_date, @ends.where(time: i.day.ago.all_day).sum(:range)])
      else
        @data.unshift([Time.current.ago(i.days).to_date, 0])
      end
      if Time.current.ago(i.days).wday == 1
        break
      end
    end  
    @today_total = @ends.where(time: Time.current.all_day ).sum(:range)
    @week_total = @data.sum.select{|num| (num.class == Integer) || (num.class == Float)}.sum
  end

  def up
    if (session[:up] == nil) || (session[:up] % 7 != Time.current.wday) || session[:up].negative?
      session[:up] = Time.current.wday
    else
      session[:up] += 7
    end
    redirect_to statictics_path
  end  

  def down
    if session[:up] != nil
        session[:up] -= 7
    end
    redirect_to statictics_path
  end

end  