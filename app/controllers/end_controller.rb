class EndController < ApplicationController
  def edit
    @end = End.find_by(id: params[:id])
  end

  def update
    @end = End.find_by(id: params[:id])
    @start = Start.find_by(id: @end.start_id)
    if @end.update(end_params)
      @end.update(range: (@end.time - @start.time).to_i )
      flash[:success] = "終了時刻が更新されました"
      redirect_to statictics_path
    else
      render 'edit'
    end
  end

  private
def end_params
    params.require(:end).permit(:time)
end

end
