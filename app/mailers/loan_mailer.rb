class LoanMailer < ActionMailer::Base
  default from: "no-reply@stuff.com"

  def loan_reminder(user, loan)
    @user = user
    @loan = loan
    @borrower = Borrower.find_by_id(@loan.borrower_id)
    mail(:to => @borrower.email, :subject => "[Stuff] Loan Reminder")
  end
end
