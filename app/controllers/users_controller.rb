class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @prototypes = @user.prototypes
    @nickname = current_user.name
#    @prototypes = current_user.prototypes
  end
end
