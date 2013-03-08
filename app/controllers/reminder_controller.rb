class ReminderController < Base::AuthenticatedController
  def show
  end

  def create
    @loan = Loan.find(params[:id])
    LoanMailer.loan_reminder(current_user, @loan).deliver
  end
end
