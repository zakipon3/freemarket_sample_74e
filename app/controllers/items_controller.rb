class ItemsController < ApplicationController
  before_action :set_params, only: :create
  before_action :set_card, only: :purchase
  before_action :set_item

  require "payjp"

  def index
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

  private
  def set_params
    params.require(:item).permit(:name, :explanation, :category_id, :size, :brand_name, :condition_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :price, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_card
  end

  def set_item
    @item = Item.find(2)
    @image = Image.find(2)
    # @item = Item.find(params[:item_id])
  end

  def detail
  end
end
