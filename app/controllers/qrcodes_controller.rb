class QrcodesController < Base::AuthenticatedController

  def index

    @objs = []

    if params.has_key? :obj_type
      obj_type = params[:obj_type]
      current_user.send(obj_type).all.each do |i|
        if i.respond_to? :to_description_hash
          @objs.push({:title => i.to_description_hash[:title], :url => send(obj_type.singularize+"_url",i.to_description_hash[:id])})
        end
      end
    end

    respond_to do |format|
      format.html # show all buckets
      format.svg { render :qrcode => params[:path], :level => :h, :unit => 4 }
    end
  end

end