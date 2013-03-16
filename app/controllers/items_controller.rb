class ItemsController < ApplicationController
  
  set_menu_item :items
  
  # GET /items
  # GET /items.json
  def index
    
    @item = Item.new # NOTE Used to create item from index page
    
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = current_user.items.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
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

    respond_to do |format|
      if @item.update_attributes(params[:item])
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
end
