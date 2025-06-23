class ShopItemsController < ApplicationController
  before_action :set_shop_item, only: [ :show, :update, :destroy ]

  # GET /shop_items
  def index
    @shop_items = ShopItem.all
    render json: @shop_items, include: :shop_item_categories
  end

  # GET /shop_items/:id
  def show
    render json: @shop_item, include: :shop_item_categories
  end

  # POST /shop_items
  def create
    @shop_item = ShopItem.new(shop_item_params)

    if @shop_item.save
      render json: @shop_item, status: :created, location: @shop_item
    else
      render json: { errors: @shop_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shop_items/:id
  def update
    if @shop_item.update(shop_item_params)
      render json: @shop_item
    else
      render json: { errors: @shop_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /shop_items/:id
  def destroy
    @shop_item.destroy
    head :no_content
  rescue ActiveRecord::InvalidForeignKey
    render json: { error: "Cannot delete shop item that is referenced in orders" }, status: :unprocessable_entity
  end

  private

  def set_shop_item
    @shop_item = ShopItem.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Shop item not found" }, status: :not_found
  end

  def shop_item_params
    params.require(:shop_item).permit(:title, :description, :price, shop_item_category_ids: [])
  end
end
