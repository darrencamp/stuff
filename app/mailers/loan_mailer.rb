class LoanMailer < ActionMailer::Base
  default from: "no-reply@stuff.com"

  def loan_reminder(user, loan)
    @user = user
    @loan = loan
    mail(:to => loan.borrower.email, :subject => "Reminder")
  end
end
