class ApplicationController < ActionController::Base
  protect_from_forgery
  
  class << self; attr_accessor :menu_item; end
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end  
  
  def self.set_menu_item(menu_item)
    self.menu_item = menu_item   
  end  
  
  def set_menu_item(menu_item)
    self.class.set_menu_item(menu_item) 
  end
  
end
