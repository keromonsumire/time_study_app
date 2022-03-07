class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_path
    else
      flash.now[:danger] = 'メールアドレスもしくはパスワードが無効です' 
      render 'new'
    end   
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
    log_in(user)
    redirect_to root_path
    flash[:success] = "ゲストユーザーとしてログインしました"
  end
end
