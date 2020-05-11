class ItemsController < ApplicationController
  before_action :set_params, only: :create

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(set_params)

    if @item.valid?
      @item.status_id = get_exhibiting_status()
      @item.save
    else
      redirect_to new_item_path
    end
  end

  private
  def set_params
    params.require(:item).permit(:name, :explanation, :category_id, :size, :brand_name, :condition_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :price)
  end

end
