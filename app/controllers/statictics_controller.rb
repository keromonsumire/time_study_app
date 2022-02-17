class StaticticsController < ApplicationController
  require "date"
  def statictics
    @user = current_user
    @starts = Start.where(user_id:@user.id)
    @ends = End.where(user_id:@user.id)
    @total = 0
    @data = []
    7.times do |i|
      if Time.now.ago(i.days).wday == 0
        break
      end
      if @ends.where(time: i.day.ago.all_day) 
        @data.unshift([Date.today.prev_day(i), @ends.where(time: i.day.ago.all_day).sum(:range)])
      else
        @data.unshift([Date.today.prev_day(i), 0])
      end
    end
    

  end

end  