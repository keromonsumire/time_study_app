class StaticticsController < ApplicationController
  require "date"
  def statictics
    @user = current_user
    @starts = Start.where(user_id:@user.id)
    @ends = End.where(user_id:@user.id)
    @total = 0
  end
end  