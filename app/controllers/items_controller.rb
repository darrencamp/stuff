require 'datafile.rb'

class ItemsController < ApplicationController
  
  set_menu_item :items
  
  # GET /items
  # GET /items.json
  def index
    
    @item = Item.new # NOTE Used to create item from index page
    @item_bucket = @item.build_bucket
    
    # NOTE Plan here is to have a variety of queries that can be called (e.g. search by name)
    @items = case params[:query]
      when nil 
        current_user.items.order('created_at DESC').all # SMELL this could get expensive. Paginate?
      else
        items = Item.arel_table
        current_user.items.where(items[:name].matches("%#{params[:query]}%")).order('name').all
      end

    respond_to do |format|
      format.html # index.html.erb
     # format.json { render json: @items.map(&:name) }
      format.json { render json: @items }
    end

  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = current_user.items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new 
    @item_bucket = @item.build_bucket

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = current_user.items.find(params[:id])
    @item_bucket = @item.bucket || @item.build_bucket
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(params[:item])

    @bucket = nil
    @bucket = current_user.buckets.find(params[:bucket_id]) unless params[:bucket_id].blank? || @item.build_bucket(params[:bucket])
    @item.bucket = @bucket

    respond_to do |format|
      if @item.save
        flash[:notice] = "Item created"
        format.html { redirect_to :back }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = current_user.items.find(params[:id])
    @item_bucket = (current_user.buckets.find(params[:bucket_id]) unless params[:bucket_id].blank?) || @item.build_bucket(params[:bucket])
    @item_bucket.user = current_user

    @item.update_attributes(params[:item])
    @item.bucket = @item_bucket

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def import
    importedItems = DataFile.new(params[:file])
    importedItems.each do |i|
      item = current_user.items.find_by_name(i["name"]) || current_user.items.new(i.to_hash)
      bucket = nil
      bucket = current_user.buckets.find_by_name(i["bucket_name"])
      if bucket.nil? && !(i["bucket_name"].blank?)
        bucket = current_user.buckets.new({:name => i["bucket_name"]})
      end
      item.bucket = bucket
      item.save!
    end
    redirect_to root_url, notice: "Products Imported."
  end
end
