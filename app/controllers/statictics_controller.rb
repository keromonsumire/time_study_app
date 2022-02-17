class StaticticsController < ApplicationController
  require "date"
  before_action :setup

  def setup
    @user = current_user
    @starts = Start.where(user_id:@user.id)
    @ends = End.where(user_id:@user.id)
    @total = 0
    @data = []
  end

  def statictics
    if session[:up] == nil
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
        @data.unshift([Date.today.prev_day(i), @ends.where(time: i.day.ago.all_day).sum(:range)])
      else
        @data.unshift([Date.today.prev_day(i), 0])
      end
      if Time.now.ago(i.days).wday == 1
        break
      end
    end  
  end

  def up
    if session[:up] == nil
      session[:up] = Time.now.wday
    else
      session[:up] += 7
    end
    redirect_to statictics_path
  end  

  def down
    if session[:up] == nil
      session[:up] = Time.now.wday - 7
    else  
      session[:up] -= 7
    end
    redirect_to statictics_path
  end

end  