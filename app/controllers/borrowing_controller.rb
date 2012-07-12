class BorrowingController < ApplicationController
  before_filter :authenticate_user!
    
  def index
    @borrowings = Borrower.where('email = ?', current_user.email)
    @borrowings.all
    
  end

end