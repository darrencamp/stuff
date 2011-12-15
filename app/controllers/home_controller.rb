class HomeController < ApplicationController

  def index
    if user_signed_in?
      @loans = Loan.find_all_by_user_id(current_user.id)
    end
  end  
end