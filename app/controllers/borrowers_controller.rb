class BorrowersController < Base::AuthenticatedController
  
  set_menu_item :borrowers
  
  # GET /borrowers
  # GET /borrowers.json
  def index
    
    @borrower = Borrower.new # NOTE Used to create borrower from index page
    
    # NOTE Plan here is to have a variety of queries that can be called (e.g. search by name)
    @borrowers = case params[:query]
      when nil 
        current_user.borrowers.order('created_at DESC').all # SMELL this could get expensive. Paginate?
      else
        borrowers = Borrower.arel_table
        current_user.borrowers.where(borrowers[:email].matches("%#{params[:query]}%")).order('email').all
      end  
      
    respond_to do |format|
      format.html # index.html.erb
     # format.json { render json: @borrowers.map(&:name) }
      format.json { render json: @borrowers }
    end

  end

  # GET /borrowers/1
  # GET /borrowers/1.json
  def show
    @borrower = current_user.borrowers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @borrower }
    end
  end

  # GET /borrowers/new
  # GET /borrowers/new.json
  def new
    @borrower = Borrower.new 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @borrower }
    end
  end

  # GET /borrowers/1/edit
  def edit
    @borrower = current_user.borrowers.find(params[:id])
  end

  # POST /borrowers
  # POST /borrowers.json
  def create
    @borrower = current_user.borrowers.new(params[:borrower])

    respond_to do |format|
      if @borrower.save
        format.html { redirect_to @borrower, notice: 'Borrower was successfully created.' }
        format.json { render json: @borrower, status: :created, location: @borrower }
      else
        format.html { render action: "new" }
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /borrowers/1
  # PUT /borrowers/1.json
  def update
    @borrower = current_user.borrowers.find(params[:id])

    respond_to do |format|
      if @borrower.update_attributes(params[:borrower])
        format.html { redirect_to @borrower, notice: 'Borrower was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowers/1
  # DELETE /borrowers/1.json
  def destroy
    @borrower = current_user.borrowers.find(params[:id])
    @borrower.destroy

    respond_to do |format|
      format.html { redirect_to borrowers_url }
      format.json { head :no_content }
    end
  end
end  
