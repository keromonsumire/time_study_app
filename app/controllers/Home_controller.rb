class HomeController < ApplicationController
    before_action :start_and_end, only: [:home,:create,:end]

    def start_and_end
        @user = current_user
        if @user != nil
        @start = Start.where(user_id: @user.id)
        @end = End.where(user_id: @user.id)
        end
    end

    def home 
        if logged_in?
            if (@start.count - 1 == @end.count)
                @new_start = Start.where(user_id: @user.id).last.created_at.to_s(:datetime_jp)

            end    
        end
    end

    def contact
    end

    def create
        if (@start.count - @end.count == 0)
            @user.starts.create(time: Time.now)
        end
        redirect_to root_url
    end   

    def end
        if (@start.count - 1 == @end.count)
            End.create(user_id:@user.id,start_id: @start.last.id, time: Time.now, range: 1.1)
        end
        redirect_to root_url
    end
    
end
