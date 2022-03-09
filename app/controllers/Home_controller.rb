class HomeController < ApplicationController
    before_action :start_and_end, only: :home

    def start_and_end
        @user = current_user
        if @user != nil
        @start = Start.where(user_id: @user.id)
        @end = End.where(user_id: @user.id)
        end
    end

    def home 
        if logged_in? && (@start.count - 1 == @end.count)
            @time = ((@start.last.time - Time.local(1970,1,1,0,0,0,0)) * 1000)
        end
    end



    def contact
    end
    
end
