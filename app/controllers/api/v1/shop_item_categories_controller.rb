class Api::V1::ShopItemCategoriesController < ApplicationController
  before_action :set_shop_item_category, only: [ :show, :update, :destroy ]

  # GET /api/v1/shop_item_categories
  def index
    @shop_item_categories = ShopItemCategory.all
    render json: @shop_item_categories
  end

  # GET /api/v1/shop_item_categories/:id
  def show
    render json: @shop_item_category
  end

  # POST /api/v1/shop_item_categories
  def create
    @shop_item_category = ShopItemCategory.new(shop_item_category_params)

    if @shop_item_category.save
      render json: @shop_item_category, status: :created
    else
      render json: { errors: @shop_item_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/shop_item_categories/:id
  def update
    if @shop_item_category.update(shop_item_category_params)
      render json: @shop_item_category
    else
      render json: { errors: @shop_item_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shop_item_categories/:id
  def destroy
    @shop_item_category.destroy
    head :no_content
  end

  private

  def set_shop_item_category
    @shop_item_category = ShopItemCategory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Shop item category not found" }, status: :not_found
  end

  def shop_item_category_params
    params.require(:shop_item_category).permit(:title, :description)
  end
end
