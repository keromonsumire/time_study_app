class StartController < ApplicationController
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
def start_params
    params.require(:start).permit(:time)
end

end
