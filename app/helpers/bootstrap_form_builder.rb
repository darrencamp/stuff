class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  
  def text_field(attribute, options={})
    label_content = options[:label] || options

    bootstrap_control(attribute, label_content) { super }     
  end
  
  def password_field(attribute, options={})
    label_content = options[:label] || options
    bootstrap_control(attribute, label_content) { super }     
  end
  
  def email_field(attribute, options={})
    label_content = options[:label] || options
    bootstrap_control(attribute, label_content, options) { super }     
  end
  
  def submit(value=nil, options={})
    options.merge!(:class => 'btn')
    @template.content_tag(:div, :class => 'control-group') do
      @template.content_tag(:div, :class => 'controls') do   
        super
      end
    end     
  end  

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    label_content = options[:label] || options
    bootstrap_control(method, label_content) { super }     
  end  
  
  def file_field(method, options = {})
    label_content = options[:label] || options
    bootstrap_control(method, label_content) { super }    
  end
    
  private
  
  def bootstrap_control(attribute, label_content, options={})
    @template.content_tag(:div, :class => 'control-group') do
      label(attribute, label_content, {:class => 'control-label'}) + 
      @template.content_tag(:div, :class => 'controls') do
        yield
      end
    end  
  end    
end