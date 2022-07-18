class AdminController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user.admin == 'admin'
      redirect_back_or_to '/admin'
    else
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end
