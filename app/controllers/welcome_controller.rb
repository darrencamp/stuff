class WelcomeController < ApplicationController

  def show
    set_menu_item :welcome    
  end
  
  def about
    set_menu_item :about  
  end  
  
end    