class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [ :show, :update, :destroy ]

  # GET /api/v1/orders
  def index
    @orders = Order.includes(:customer, :order_items, :shop_items).all
    render json: @orders, include: [ :customer, :order_items, :shop_items ]
  end

  # GET /api/v1/orders/:id
  def show
    render json: @order, include: [ :customer, :order_items, :shop_items ]
  end

  # POST /api/v1/orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, include: [ :customer, :order_items, :shop_items ], status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/orders/:id
  def update
    if @order.update(order_params)
      render json: @order, include: [ :customer, :order_items, :shop_items ]
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.includes(:customer, :order_items, :shop_items).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Order not found" }, status: :not_found
  end

  def order_params
    params.require(:order).permit(:customer_id, order_items_attributes: [ :shop_item_id, :quantity ])
  end
end
