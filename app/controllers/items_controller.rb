class ItemsController < ApplicationController
  before_action :set_params, only: :create
  before_action :set_category
  before_action :set_item, only: [:show, :edit]

  def index
    @items = Item.all.where(status_id: '1').order(created_at: :desc)
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(set_params)
    if @item.valid?
      @item.status_id = EXHIBITING_STATUS
      unless @item.save
        redirect_to new_item_path, flash: { error: @item.errors.full_messages }
      end
    else
      redirect_to new_item_path, flash: { error: @item.errors.full_messages }
    end
  end

  def show
    @item_images = @item.images
    @image = @item_images.first
  end

  def edit
  end

  def list
    @items = Item.where(status_id: '1').order(created_at: :desc)
  end

  def set_parents
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

  def set_category
    @parents = Category.where(ancestry: nil).order("id ASC").limit(13)
  end

  private
  def set_params
    params.require(:item).permit(:name, :explanation, :category_id, :size, :brand_name, :condition_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :price, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
