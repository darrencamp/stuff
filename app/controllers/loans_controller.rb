class LoansController < Base::AuthenticatedController
   
  set_menu_item :loans
  
  autocomplete :item, :name
    
  def index
    @loan = Loan.new # NOTE Used to create item from index page
    
    @loans = current_user.loans.where('returned_date is null')
    @loans.where('user_id = ?', current_user.id)
    @loans.all
  end
  
  def show
    @loan = Loan.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @loan = Loan.new
  end
  
  def create    
    @loan = current_user.loans.new # NOTE Pick up current user
    @loan.update_attributes(:borrower_attributes => params[:borrower], :item_attributes => params[:item])
    
    respond_to do |format|
      if @loan.save
        format.html { 
          flash[:notice] = 'loan created.'
          redirect_to(controller: 'home', action: 'index') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    # SMELL   Is this really what is meant by the verb "DELETE". I kinda get it, but 
    #         it feels that 'returned' should be a status of a loan 
    @loan = current_user.loans.find(params[:id])
    @loan.returned_date = DateTime.now
    
    respond_to do |format|
      if @loan.save
        flash[:notice] = 'Loan was sucessfully returned.'
        format.html { redirect_to :action => "index" }
      else
        flash[:error] = 'Loan could not be successfully returned.'
        format.html { redirect_to @loan }
      end
    end
  end
  
end
