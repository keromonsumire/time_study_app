class StaticticsController < ApplicationController
  require "date"
  before_action :setup

  def setup
    @user = current_user
    @starts = Start.where(user_id:@user.id).order("time DESC").paginate(page: params[:page])
    @ends = End.where(user_id:@user.id)
    @total = 0
    @data = []
  end

  def statictics
    if (session[:up] == nil) || (session[:up] % 7 != Time.now.wday) || session[:up].negative?
      @up = 0
    else
      @up = session[:up]
    end

    if (Time.now.wday != 0) && (@up == 0)
      1.upto(7 - Time.now.wday) do |i|
        @data.push([Date.today.next_day(i), 0])
      end
    end

    @up.upto(@up + 7) do |i|
      if @ends.where(time: i.day.ago.all_day) 
        @data.unshift([Date.today.prev_day(i), @ends.where(time: i.day.ago.all_day).sum(:length)])
      else
        @data.unshift([Date.today.prev_day(i), 0])
      end
      if Time.now.ago(i.days).wday == 1
        break
      end
    end  
    @today_total = @ends.where(time: Time.current.all_day ).sum(:length)
    @week_total = @data.sum.select{|num| (num.class == Integer) || (num.class == Float)}.sum
  end

  def up
    if (session[:up] == nil) || (session[:up] % 7 != Time.now.wday) || session[:up].negative?
      session[:up] = Time.now.wday
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