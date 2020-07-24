class ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
  end

  def created
  end
end
