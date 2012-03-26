class HomeController < ApplicationController

  def index
    if user_signed_in?
      @loans = Loan.where('returned_date is null')
      @loans.where('user_id = ?', current_user.id)
      @loans.all
    end
  end  
  
end