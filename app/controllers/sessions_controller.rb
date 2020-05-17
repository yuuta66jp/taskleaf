class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    # authenticateメソッド(引数のpasswordを使って認証を行い正しければUserオブジェクトを返し、正しくなければfalseを返す)
    # ぼっち演算子でnilガード
    if user&.authenticate(session_params[:password])
      # session[:user_id]にログインユーザーのIDを格納(ログイン状態)
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    # セッション内の情報を全て削除
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
