module ApplicationHelper
  
  def menu_item_li_class(menu_item)
    'active' if controller.class.menu_item == menu_item    
  end  
  
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true, :filter_html => true)
    options = {autolink: true, no_intra_emphasis: true, fenced_code: true, gh_blockcode: true}
    md = Redcarpet::Markdown.new(renderer, extensions = options)
    md.render(text).html_safe
  end
end
