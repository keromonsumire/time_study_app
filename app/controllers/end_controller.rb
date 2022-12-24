class EndController < ApplicationController
before_action :logged_in_user
before_action :correct_user, only: [:destroy, :edit, :update]

  def create
    @user = current_user
    if @user != nil
        @start = Start.where(user_id: @user.id)
        @end = End.where(user_id: @user.id)
    end    
    if (@start.count - 1 == @end.count)
        End.create(user_id:@user.id,start_id: @start.last.id, time: Time.current, range:((Time.now - @start.last.time)/3600).to_f)
    end
    redirect_to "/break"
    if @end.where(time: Time.current.all_day).sum(:range) >= 1
      flash[:success] = "計測完了！ 1時間以上頑張って偉いね！"
    else
      flash[:success] = "計測完了！　お疲れ様"
    end
  end

  def edit
    @end = End.find_by(id: params[:id])
  end

  def update
    @end = End.find_by(id: params[:id])
    @start = Start.find_by(id: @end.start_id)
    if @end.update(end_params)
      @end.update(range: ((@end.time - @start.time) / 3600).to_f)
      flash[:success] = "終了時刻が更新されました"
      redirect_to statictics_path
    else
      render 'edit'
    end
  end

  def edit_memo
    @end = End.find_by(id: params[:id])
  end

  def update_memo
    @end = End.find_by(id: params[:id])
    if @end.update(end_params)
      @end.update(end_params)
      flash[:success] = "メモが追加されました"
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
  @end = End.find_by(id: params[:id])
  @user = User.find_by(id: @end.user_id)
  redirect_to root_path unless current_user?(@user)
end

def end_params
    params.require(:end).permit(:time, :memo)
end

end
