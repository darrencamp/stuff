class QrcodesController < Base::AuthenticatedController

  def index
    @buckets = current_user.buckets.all #SMELL: paginate
    
    respond_to do |format|
      format.html # show all buckets
      format.svg { render :qrcode => params[:path], :level => :h, :unit => 4 }
    end
  end

end