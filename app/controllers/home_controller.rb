class HomeController < Base::AuthenticatedController

  before_filter :redirect_to_welcome
  
  set_menu_item :home
  
  def index
    @loans = Loan.where('returned_date is null')
    @loans.where('user_id = ?', current_user.id)
    @loans.all

    @borrowing = Borrower.where('email = ?', current_user.email)
    @borrowing.all
  end  
  
  def redirect_to_welcome
    redirect_to welcome_path, :flash => flash unless user_signed_in?   
  end  
end