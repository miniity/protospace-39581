class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
    @nickname = current_user.name if user_signed_in? # ログインしている場合のみ処理を行う
  end
end
