class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @nickname = current_user.nickname
  end

  def card
  end

  def new
  end
  
  def edit
  end

  def create
  end

  def show
  end

  def logout
  end
end
