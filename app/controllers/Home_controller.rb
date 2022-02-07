class HomeController < ApplicationController
    def home 
        if logged_in?
            @user = current_user
            if (Start.where(user_id: @user.id).count - 1 == End.where(user_id: @user.id).count)
                @new_start = Start.where(user_id: @user.id).last.created_at.to_s(:datetime_jp)

            end    
        end
    end

    def contact
    end

    def create
        @user = current_user
        if (Start.where(user_id: @user.id).count - End.where(user_id: @user.id).count == 0)
            @user.starts.create
        end
        redirect_to root_url
    end   

    def end
        @user = current_user
        if (Start.where(user_id: @user.id).count - 1 == End.where(user_id: @user.id).count)
            @end = End.new(user_id:@user.id)
            @end.save
        end
        redirect_to root_url
    end
    
end
