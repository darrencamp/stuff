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
    @borrower = Borrower.create!(:name => 'foo')
    @loan = Loan.new
    @loan.borrower = @borrower
  end
  
  def create
    #NOTE #CONTRACT 
    raise 'Params MUST identify a borrower.' if params[:borrower_id].nil? && params[:borrower_name].nil? 
    raise 'Params MUST identify an item.' if params[:item_id].nil? && params[:item_name].nil? 
    
    # Need to intercept params where the item or borrower is new (i.e identified by string)
    
    # Check if existing / new borrower
    # Does it have an ID?
      # Yes: Use existing borrower. 
      #   Maybe check that the ID matches the text, if same.. same object? 
      #   If not, new borrower
      # No: Build a new borrower (should we check if the name of the borrower already exists? Are names unique?)
    # Fail early - no borrower, no loan
      
    # NOTE Simple, first cut  
    @borrower = if params[:borrower_id]
        current_user.items.find params[:borrower_id]
      else
        Borrower.create! :email => params.delete(:borrower_email)
      end  
    
    #NOTE #CONTRACT     
    raise 'Params MUST identify a *valid* borrower.' unless @borrower
    
    # Check if existing / new item
    # Does it have an ID?
      # Yes: Check that the ID matches the text, if same.. same object. If not, new item
      # No: Build a new item (should we check if the name of the item already exists? Are names unique?)
      
    # Fail early - no item, no loan  
    
    # NOTE Simple, first cut  
    @item = if params[:item_id]
        current_user.borrowers.find params[:item_id]
      else
        current_user.borrower.create! :name => params.delete(:item_name) # Pop :item_name out  
      end  
     
    #NOTE #CONTRACT     
    raise 'Params MUST identify a *valid* item.' unless @item
    
    #SMELL Duplicated code / comments above    
    
    # NOTE Copy borrower and item IDs into params so we can build the loan object in one pass 
    params[:loan].merge!({:borrower_id => @borrower.id, :item_id => @item.id})
    
    @loan = current_user.loans.new params[:loan]
    
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
    @loan = current_users.loans.find(params[:id])
    @loan.returned_date = DateTime.now
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to :action => "index", :notice => 'Loan was sucessfully returned.' }
      else
        format.html { redirect_to @loan, :notice => 'Loan could not be successfully returned.' }
      end
    end
  end
  
end
