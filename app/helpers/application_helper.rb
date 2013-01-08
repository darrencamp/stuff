module ApplicationHelper
  
  def menu_item_li_class(menu_item)
    puts "++"
    puts controller.class
    'active' if controller.class.menu_item == menu_item    
  end  
end
