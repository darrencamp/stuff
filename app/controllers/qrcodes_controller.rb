class QrcodesController < Base::AuthenticatedController

  def index
    respond_to do |format|
      format.svg { render :qrcode => params[:path], :level => :h, :unit => 4 }
    end
  end

end