class ItemsController < ApplicationController
  def index
    @items = Item.all.where(status_id: '1').order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def detail
  end

  def list
    @items = Item.all.where(status_id: '1').order(created_at: :desc)
  end
end
