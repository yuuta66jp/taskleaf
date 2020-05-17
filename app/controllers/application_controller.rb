class ApplicationController < ActionController::Base
  # helper_methodで全てのビューからも使用できるようにする
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    # 自己代入演算子で代入
    # findメソッドの場合nilを渡した際エラーが発生するためfind_byを使用(nilが返ってくる)
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end
end
