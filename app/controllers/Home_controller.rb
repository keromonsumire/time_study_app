class HomeController < ApplicationController
    def home 
    end

    def contact
    end

    def create
        @user = current_user
        if (Start.where(user_id: 1).count - End.where(user_id: 1).count == 0)
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
    end
    
end
