class PdfsController < ApplicationController
  layout "pdf"

  def show
    @path = params[:path]

    respond_to do |format|
      format.pdf { render file: "#{Rails.root}/public/404.html" }
      format.any
    end
  end

end
