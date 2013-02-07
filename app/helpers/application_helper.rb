module ApplicationHelper
  
  def menu_item_li_class(menu_item)
    'active' if controller.class.menu_item == menu_item    
  end  
  
  
end
