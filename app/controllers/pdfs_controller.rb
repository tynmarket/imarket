class PdfsController < ApplicationController
  layout "pdf"

  def show
    path = params[:path]
    pdf = path&.split("/")&.last
    @pdf = "#{pdf}.pdf"
    @code = Disclosure.find_by(pdf: @pdf)&.code
  end

end
