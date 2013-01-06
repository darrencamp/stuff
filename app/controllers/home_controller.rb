class HomeController < ApplicationController

  before_filter :redirect_to_welcome
  
  def index
    if user_signed_in?
      @loans = Loan.where('returned_date is null')
      @loans.where('user_id = ?', current_user.id)
      @loans.all

      @borrowing = Borrower.where('email = ?', current_user.email)
      @borrowing.all
    end
  end  
  
  def redirect_to_welcome
    redirect_to welcome_path, :flash => flash if !user_signed_in?   
  end  
end