class HomeController < Base::AuthenticatedController

  before_filter :redirect_to_welcome
  
  autocomplete :borrower, :name
  
  set_menu_item :home
  
  def index
    @recent_loans = Loan.where('returned_date is null').where('user_id = ?', current_user.id).order('created_at DESC')

    @borrowing = Borrower.where('email = ?', current_user.email)
    @borrowing.all
  end  
  
  def redirect_to_welcome
    redirect_to welcome_path, :flash => flash unless user_signed_in?   
  end  
end