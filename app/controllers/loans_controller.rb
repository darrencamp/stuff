class LoansController < ApplicationController
  def index
    
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
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice => 'Loan was successully created.'}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end
