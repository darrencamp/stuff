class LoansController < ApplicationController
  
  before_filter :authenticate_user!
    
  def index
    @loans = Loan.find_all_by_user_id(current_user.id)
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
        format.html { redirect_to @loan, notice => 'Loan was successully created.'}
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
        format.html { redirect_to root_url }
      else
        format.html { redirect_to home_path }
      end
    end
  end
  
end
