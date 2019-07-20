class PdfsController < ApplicationController
  layout "pdf"

  def show
    @path = params[:path]
    pdf = @path&.split("/")&.last
    @code = Disclosure.find_by(pdf: pdf)&.code

    respond_to do |format|
      format.pdf { render file: "#{Rails.root}/public/404.html" }
      format.any
    end
  end

end
