class ItemsController < ApplicationController
  before_action :set_params, only: :create
  before_action :set_item, only: [:show, :edit, :update, :destroy, :purchase]
  before_action :set_category
  require "payjp"

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

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category = Category.where(ancestry: nil)
    @category_children_array = Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)
  end

  def update
    if @item.valid?
      unless @item.update(set_params)
        redirect_to edit_item_path, flash: { error: @item.errors.full_messages }
      end
    else
      redirect_to new_item_path, flash: { error: @item.errors.full_messages }
    end
  end

  def show
    @item_images = @item.images
    @image = @item_images.first
  end

  def destroy
    if @item.seller_id == current_user.id
      if @item.destroy
        redirect_to root_path, notice: "削除が完了しました"
      else
        redirect_to root_path, alert: "削除に失敗しました"
      end
    end
  end

  def list
    @items = Item.where(status_id: '1').order(created_at: :desc)
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

  def purchase
    if user_signed_in?
      @card = Creditcard.find_by(user_id: current_user.id)
      if @card.blank?
        redirect_to card_mypage_index_path, alert: "カードを登録してください"
      else
        Payjp.api_key = Rails.application.credentials.pay_jp[:payjp_private_key]
        #保管した顧客IDでpayjpから情報取得
        customer = Payjp::Customer.retrieve(@card.customer_id) 
        #カード情報表示のためインスタンス変数に代入
        @default_card_information = customer.cards.retrieve(@card.card_id)
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  # def pay
  #   Payjp.api_key = Rails.application.credentials.pay_jp[:payjp_private_key]
  #   Payjp::Charge.create(
  #     amount: @item.price, #支払金額を引っ張ってくる
  #     customer: @card.customer_id,  #顧客ID
  #     currency: 'jpy',              #日本円
  #   )
  #   redirect_to done_item_buyers_path
  #   end
  def set_images
    @images = Image.where(item_id: params[:id])
  end

  def set_category
    @parents = Category.where(ancestry: nil).order("id ASC").limit(13)
  end

  private
  def set_params
    params.require(:item).permit(:name, :explanation, :category_id, :size, :brand_name, :condition_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :price, images_attributes: [:image, :id, :_destroy]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(2)
    @image = Image.find(2)
    # @item = Item.find(params[:item_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
