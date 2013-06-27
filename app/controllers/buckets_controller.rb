class BucketsController < Base::AuthenticatedController
  set_menu_item :buckets
  respond_to :html, :json

  # GET /buckets
  # GET /buckets.json
  def index
    
    @bucket = Bucket.new # NOTE Used to create item from index page
    
    # NOTE Plan here is to have a variety of queries that can be called (e.g. search by name)
    @buckets = case params[:query]
      when nil 
        current_user.buckets.all # SMELL this could get expensive. Paginate?
      else
        buckets = Bucket.arel_table
        current_user.buckets.where(buckets[:name].matches("%#{params[:query]}%")).order('name').all
      end  

    respond_with @buckets
  end

  # GET /buckets/1
  # GET /buckets/1.json
  def show
    @bucket = current_user.buckets.find(params[:id])
    @item = Item.new
    @item.bucket = @bucket
    #smell: ask tom about this...I'm not sure how to handle this.
    @item_bucket = @item.bucket

    respond_with @bucket
  end

  # GET /buckets/1/edit
  def edit
    @bucket = current_user.buckets.find(params[:id])
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = current_user.buckets.new(params[:bucket])

    respond_to do |format|
      if @bucket.save
        flash[:notice] = "Bucket created"
        format.html { redirect_to action: 'index' }
        format.json { render json: @bucket, status: :created, location: @bucket }
      else
        format.html { render action: "new" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buckets/1
  # PUT /buckets/1.json
  def update
    @bucket = current_user.buckets.find(params[:id])
    @bucket.update_attributes(params[:bucket])
    respond_with @bucket
  end

    # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @bucket = current_user.buckets.find(params[:id])
    @bucket.destroy

    respond_to do |format|
      format.html { redirect_to buckets_url }
      format.json { head :no_content }
    end
  end


end