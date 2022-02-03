class StaticticsController < ApplicationController
  def statictics
    @user = current_user
    @starts = Start.where(user_id:@user.id)
    @ends = End.where(user_id:@user.id)
  end
end  