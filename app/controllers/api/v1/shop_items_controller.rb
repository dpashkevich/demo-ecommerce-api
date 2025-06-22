class Api::V1::ShopItemsController < ApplicationController
  before_action :set_shop_item, only: [ :show, :update, :destroy ]

  # GET /api/v1/shop_items
  def index
    @shop_items = ShopItem.includes(:shop_item_categories).all
    render json: @shop_items, include: :shop_item_categories
  end

  # GET /api/v1/shop_items/:id
  def show
    render json: @shop_item, include: :shop_item_categories
  end

  # POST /api/v1/shop_items
  def create
    @shop_item = ShopItem.new(shop_item_params)

    if @shop_item.save
      render json: @shop_item, include: :shop_item_categories, status: :created
    else
      render json: { errors: @shop_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/shop_items/:id
  def update
    if @shop_item.update(shop_item_params)
      render json: @shop_item, include: :shop_item_categories
    else
      render json: { errors: @shop_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shop_items/:id
  def destroy
    @shop_item.destroy
    head :no_content
  end

  private

  def set_shop_item
    @shop_item = ShopItem.includes(:shop_item_categories).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Shop item not found" }, status: :not_found
  end

  def shop_item_params
    params.require(:shop_item).permit(:title, :description, :price, shop_item_category_ids: [])
  end
end
