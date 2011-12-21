class HomeController < ApplicationController

  def index
    if user_signed_in?
      @loans = Loan.where('returned_date is null and user_id = ?', current_user.id)
    end
  end  
  
end