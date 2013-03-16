class ApplicationController < ActionController::Base
  protect_from_forgery
  
  class << self; attr_accessor :menu_item; end

  protected
  
  def self.set_menu_item(menu_item)
    self.menu_item = menu_item   
  end  
  
  def set_menu_item(menu_item)
    self.class.set_menu_item(menu_item) 
  end
  
end
