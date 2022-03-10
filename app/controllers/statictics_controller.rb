class StaticticsController < ApplicationController
  require 'date'
  before_action :setup

  def setup
    @user = current_user
    @starts = Start.where(user_id:@user.id).order("time DESC").paginate(page: params[:page])
    @ends = End.where(user_id:@user.id)
    @total = 0
    @week_data = []
    @month_data = []
  end

  def statictics
    if (session[:up] == nil) || (session[:up] % 7 != Time.current.wday) || session[:up].negative?
      @up = 0
    else
      @up = session[:up]
    end

    if (Time.now.wday != 0) && (@up == 0)
      1.upto(7 - Time.current.wday) do |i|
        @week_data.push([Time.current.since(i.days).to_date.month.to_s + "/" + Time.current.since(i.days).to_date.day.to_s, 0])
      end
    end

    @up.upto(@up + 7) do |i|
      if @ends.where(time: i.day.ago.all_day) 
        @week_data.unshift([(Time.current.ago(i.days).to_date.month.to_s + "/" + Time.current.ago(i.days).to_date.day.to_s), @ends.where(time: i.day.ago.all_day).sum(:range)])
      else
        @week_data.unshift([(Time.current.ago(i.days).to_date.month.to_s + "/" + Time.current.ago(i.days).to_date.day.to_s), 0])
      end
      if Time.current.ago(i.days).wday == 1
        break
      end
    end  

    if session[:month] == nil
      session[:month] = 0
    end  

    if session[:week_or_month] == nil
      session[:week_or_month] = 0
    end
      100.times do |i|
        point = Time.current.ago(session[:month].month).end_of_month.ago(i.days)
        if @ends.where(time: point.all_day)
          @month_data.unshift([(point.to_date.month.to_s + "/" + point.to_date.day.to_s), @ends.where(time: point.all_day).sum(:range)])
        else
          @month_data.unshift([(point.to_date.month.to_s + "/" + point.to_date.day.to_s), 0])
        end
          if point.day == 1
            break
          end
      end
    @today_total = @ends.where(time: Time.current.all_day ).sum(:range)
    @week_total = @week_data.sum.select{|num| (num.class == Integer) || (num.class == Float)}.sum
    @month_total = @month_data.sum.select{|num| (num.class == Integer) || (num.class == Float)}.sum

  end

  def point_up 
    session[:month] += 1
    redirect_to statictics_path
  end

  def point_down
    session[:month] -= 1
    redirect_to statictics_path
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

  def change_to_month
    session[:week_or_month] = 1
    redirect_to statictics_path
  end

  def change_to_week
    session[:week_or_month] = 0
    redirect_to statictics_path
  end

end  