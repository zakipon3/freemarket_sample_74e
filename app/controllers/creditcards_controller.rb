class CreditcardsController < ApplicationController
  require "payjp"

  def index
    # すでにクレジットカードが登録しているか？
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = ENV[:PAYJP_PRIVATE_KEY]
      # PAY.JPから顧客情報を取得する。
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      @card_info = customer.cards.retrieve(customer.default_card)
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの画像を表示するために、カード会社を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 

      # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def new
    @card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?
  end

  def create
    Payjp.api_key = Rails.application.credentials.pay_jp[:payjp_private_key]
    if params['payjpToken'].blank?
      render "new"
    else
      customer = Payjp::Customer.create(
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        if request.referer&.include?("/registrations/step5")
          redirect_to controller: 'registrations', action: "step6"
        else
          redirect_to action: "index", notice:"支払い情報の登録が完了しました"
        end
      else
        render 'new'
      end
    end
  end

  def destroy     
    # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりcreateメソッドが複雑にならない。
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end
end


#   def new
#     card = Creditcard.where(user_id: current_user.id)
#     redirect_to index_path(current_user.id) if card.exists?
#   end


#   def pay #payjpとCardのデータベース作成
#     Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
#     #保管した顧客IDでpayjpから情報取得
#     if params['payjp-token'].blank?
#       redirect_to new_card_path
#     else
#       customer = Payjp::Customer.create(
#         card: params['payjp-token'],
#         metadata: {user_id: current_user.id}
#       ) 
#       @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#       if @card.save
#         redirect_to card_path(current_user.id)
#       else
#         redirect_to pay_cards_path
#       end
#     end
#   end

#   def destroy #PayjpとCardデータベースを削除
#     card = Creditcard.find_by(user_id: current_user.id)
#     if card.blank?
#     else
#       Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       customer.delete
#       card.delete
#     end
#       redirect_to new_card_path
#   end

#   def show #Cardのデータpayjpに送り情報を取り出す
#     card = Creditcard.find_by(user_id: current_user.id)
#     if card.blank?
#       redirect_to new_card_path 
#     else
#       Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       @default_card_information = customer.cards.retrieve(card.card_id)
#     end
#   end


