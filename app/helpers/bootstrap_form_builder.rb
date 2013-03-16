class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  
  def text_field(method, options={})
    label_content = options[:label] || options
    bootstrap_control(method, label_content, options) { super }     
  end
  
  def password_field(method, options={})
    label_content = options[:label] || options
    bootstrap_control(method, label_content, options) { super }     
  end
  
  def email_field(method, options = {})
    label_content = options[:label] || options
    bootstrap_control(method, label_content, options) { super }     
  end
  
  def submit(value=nil, options={})
    
    # SMELL Multiple SMELLs!
    
    # SMELL I'm just being slack here, but I'm avoiding a check for nil.
    #   Still, I can see a reason to add more :type values here
    case options[:type]
      # SMELL space required at end of :class = 'string' to avoid trashing options[:class] if used   
      when :large then options[:class] = 'btn btn-large btn-primary ' + options[:class].to_s # nil.to_s = '' 
        
      when :small then options[:class] = 'btn btn-small btn-primary ' + options[:class].to_s # nil.to_s = '' 
    end   
    # SMELL remember to remove :type and other spurious tags

    button_class = options[:class] ||= 'btn' # SMELL repeated 'btn' class from above
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
  
  def typeahead_field(method, options = {})
    text_field(method, options.merge(:class => 'typeahead', :autocomplete => 'off', :'data-source' => options[:source] ))
  end
    
  def typeahead_email_field(method, options = {})  
    email_field(method, options.merge(:class => 'typeahead', :autocomplete => 'off', :'data-source' => options[:source], :'data-display-field' => options[:display_field] || 'name' ))  
  end    
    # SMELL use data- fields to set the url, etc??
    # 
    # label_content = options[:label] || options
    # content = @template.content_tag(:input, nil, :type => "text", :autocomplete => "off")
    # content += @template.content_tag(:input, nil, :type => "hidden")
    # content
    
    # <input class="typeahead" id="item_name" name="item[name]" type="text" autocomplete="off" data-source="/items.json" data-update-id="#item_id" >

    
  private
  
  #NOTE options[:label] => false stops the label displaying
  #TODO #BUG  The way these controls get setup is wrong. You can't do inline forms if you wrap      
  #           things like this.  
  def bootstrap_control(method, label_content, options={})
    # NOTE This used to be a ternary operator. Is it easier to read like this? It still feels clunky.
    
    label_tag = if options[:label] == false 
        "".html_safe 
      else
        label(method, label_content, {:class => 'control-label'}) 
      end
        
    #NOTE Commenting out the control classes so we don't have fat forms. See #BUG note above    
    @template.content_tag(:div, :class => 'xcontrol-group') do
      label_tag + 
      @template.content_tag(:div, :class => 'xcontrols') do
        yield
      end
    end  
  end    
  
  def bootstrap_checkbox(method, label_content, options={})
    label(method, label_content, {:class => 'checkbox control-label'}) do
      yield + options[:label] # Adds the label text into the containing <label> tag
    end
  end    
end