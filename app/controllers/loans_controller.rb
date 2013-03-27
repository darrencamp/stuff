class LoansController < Base::AuthenticatedController
   
  set_menu_item :loans
  
  autocomplete :item, :name
    
  def index
    @loan = current_user.loans.new # NOTE Used to create item from index page
    @loan_borrower = @loan.build_borrower
    
    # SMELL returned_date is a magic field. Use AASM instead
    @loans = current_user.loans.where('returned_date is null').includes(:borrower).includes(:item).order('created_at DESC')
    @loans.all
  end
  
  def show
    @loan = Loan.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def new
    @loan = current_user.loans.new
    @borrower = @loan.build_borrower
  end
  
  def create    
    @loan = current_user.loans.new # NOTE Pick up current user
    
    # Determine borrower
    @borrower = nil
    @borrower = current_user.borrowers.find(params[:borrower_id]) unless params[:borrower_id].blank?    
    @borrower = current_user.borrowers.find_or_initialize_by_email(params[:borrower]) unless @borrower
    @loan.borrower = @borrower
        
    # Determine item
    @item = nil
    @item = current_user.items.find(params[:item_id]) unless params[:item_id].blank?    
    @item = current_user.items.find_or_initialize_by_name(params[:item]) unless @item   
    @loan.item = @item
    
    respond_to do |format|
      if @loan.save
        flash[:notice] = 'Loan created'
        format.html { redirect_to action: 'index' }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    # SMELL   Is this really what is meant by the verb "DELETE". I kinda get it, but 
    #         it feels that 'returned' should be a status of a loan. See note re AASM
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
