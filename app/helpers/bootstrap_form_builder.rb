class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  
  def text_field(attribute, options={})
    label_content = options[:label] || options

    bootstrap_control(attribute, label_content, options) { super }     
  end
  
  def password_field(attribute, options={})
    label_content = options[:label] || options
    bootstrap_control(attribute, label_content, options) { super }     
  end
  
  def email_field(attribute, options={})
    label_content = options[:label] || options
    bootstrap_control(attribute, label_content, options) { super }     
  end
  
  def submit(value=nil, options={})
    button_class = options[:class] ||= 'btn'
    options.merge!(:class => button_class)
    @template.content_tag(:div, :class => 'control-group') do
      @template.content_tag(:div, :class => 'controls') do   
        super
      end
    end     
  end  

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    label_content = options[:label] || options
    bootstrap_checkbox(method, label_content, options) { super }     
  end  
  
  def file_field(method, options = {})
    label_content = options[:label] || options
    bootstrap_control(method, label_content, options) { super }    
  end
    
  private
  
  def bootstrap_control(attribute, label_content, options={})
    label_tag = options[:label] == false ? "".html_safe : label(attribute, label_content, {:class => 'control-label'}) 

    @template.content_tag(:div, :class => 'control-group') do
      label_tag + 
      @template.content_tag(:div, :class => 'controls') do
        yield
      end
    end  
  end    
  
  def bootstrap_checkbox(attribute, label_content, options={})
    label(attribute, label_content, {:class => 'checkbox control-label'}) do
      yield + options[:label]
    end
  end    
end