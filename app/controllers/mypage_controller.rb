class MypageController < ApplicationController
  before_action :authenticate_user! , only: [:index, :card, :logout, :new]

  def index
  end

  def card
  end

  def logout
  end

  def new
  end

  def edit
  end

  def create
  end

  def show
  end
end
