class ItemsController < ApplicationController
  def index
    @items = Item.all
    # .older(created_at: :desc)
  end

  def new
    # @new = New.all
  end

  def create
  end

  def show
  end

  def detail
  end
end
