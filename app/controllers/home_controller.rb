class HomeController < ApplicationController

  def index
    @loans = Loan.all
  end  
end