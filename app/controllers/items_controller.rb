class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def detail
  end

  private
  def item_params
    params.require(:item).permit(:title, :content).merge(user_id: current_user.id)
  end
end
