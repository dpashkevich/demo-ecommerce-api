class OrdersController < ApplicationController
  before_action :set_order, only: [ :show, :update, :destroy ]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders, include: { order_items: { include: :shop_item } }
  end

  # GET /orders/:id
  def show
    render json: @order, include: { order_items: { include: :shop_item } }
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:id
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Order not found" }, status: :not_found
  end

  def order_params
    params.require(:order).permit(
      :customer_id,
      order_items_attributes: [ :id, :shop_item_id, :quantity, :_destroy ]
    )
  end
end
