class UsersController < ApplicationController
  def index
    if current_user.nil?
      render action: :new
    end
  end

  def show
  end

  def create
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
