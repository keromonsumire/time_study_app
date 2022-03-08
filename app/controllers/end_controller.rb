class EndController < ApplicationController

  def create
    @user = current_user
    if @user != nil
        @start = Start.where(user_id: @user.id)
        @end = End.where(user_id: @user.id)
    end    
    if (@start.count - 1 == @end.count)
        End.create(user_id:@user.id,start_id: @start.last.id, time: Time.current, range:((Time.now - @start.last.time)/3600).to_f)
    end
    redirect_to root_url
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
def end_params
    params.require(:end).permit(:time, :memo)
end

end
