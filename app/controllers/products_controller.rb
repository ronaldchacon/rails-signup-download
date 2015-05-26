class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :identify_product

  def show
    send_file @path, :disposition => "attachment; filename=#{@file}"
  end

  private
  def identify_product
    valid_characters = "^[0-9a-zA-Z]*$".freeze
    unless params[:id].blank?
      @product_id = params[:id]
      @product_id = @product_id.tr("^#{valid_characters}", '')
    else
      raise "Filename missing"
    end
    unless params[:format].blank?
      @format = params[:format]
      @format = @format.tr("^#{valid_characters}", '')
    else
      raise "File extension missing"
    end
    case current_user.role
      when 'vip'
        @path = "app/views/products/vip/#{@product_id}.#{@format}"
      when 'user'
        @path = "app/views/products/#{@product_id}.#{@format}"
    end
    @file = "#{@product_id}.#{@format}"
  end

end