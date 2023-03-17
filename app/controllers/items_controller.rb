class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
    items = Item.all
    render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private
  def item_params
    params.permit(:name, :description, :price)
  end
  def user_not_found
    render json: {errors: "Resource Not found"}, status: :not_found
  end

end
