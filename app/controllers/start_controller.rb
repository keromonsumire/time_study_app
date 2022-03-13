class StartController < ApplicationController
before_action :logged_in_user
before_action :correct_user, only: [:destroy, :edit, :update]

def create
    @user = current_user
    if @user != nil
        @start = Start.where(user_id: @user.id)
        @end = End.where(user_id: @user.id)
    end    

    if (@start.count - @end.count == 0)
        @user.starts.create(time: Time.current)
    end
    redirect_to root_url
end   

def destroy
    Start.find(params[:id]).destroy
    flash[:success] = "記録は削除されました"
    redirect_to statictics_path
end

def edit
    @start = Start.find_by(id:params[:id])
end

def update
    @start = Start.find_by(id:params[:id])
    @end = End.find_by(start_id: @start.id)
    if @start.update(start_params)
        @end.update(range: ((@end.time - @start.time)/ 3600).to_f)
        flash[:success] = "開始時刻が更新されました"
        redirect_to statictics_path
      else
        render 'edit'
      end
end

private
def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def correct_user
    @start = Start.find_by(id: params[:id])
    @user = User.find_by(id: @start.user_id)
    redirect_to root_path unless current_user?(@user)
  end

def start_params
    params.require(:start).permit(:time)
end

end
