class PdfsController < ApplicationController
  layout "pdf"

  def show
    @path = params[:path]
    pdf = @path&.split("/")&.last
    @code = Disclosure.find_by(pdf: pdf)&.code
  end

end
