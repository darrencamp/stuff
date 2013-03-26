class HomeController < Base::AuthenticatedController

  before_filter :redirect_to_welcome

  set_menu_item :home
  
  def index
    @loan = current_user.loans.new
    @borrower = @loan.build_borrower
    @item = current_user.items.new
    @recent_loans = current_user.loans.where('returned_date is null').includes(:borrower).includes(:item).order('created_at DESC').limit(10)
    
  #  @recent_loans = current_user.loans.where('returned_date is null').order('created_at DESC')

    # SMELL this really requires a social connection between current user and loans from
    # another user
    # @borrowing = Borrower.where('email = ?', current_user.email)
    # @borrowing.all
    
    flash[:notice] = "You must be new here" if @recent_loans.empty?
  end  
  
  def redirect_to_welcome
    redirect_to welcome_path, :flash => flash unless user_signed_in?   
  end  
end