class LoansController < ApplicationController
  
  before_filter :authenticate_user!
    
  def index
    @loans = Loan.where('returned_date is null')
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
    @loan = Loan.new(params[:loan])
    @loan.user_id = current_user.id
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @loan = Loan.find(params[:id])
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
