class PdfsController < ApplicationController
  layout "pdf"

  def show
    respond_to do |format|
      format.any
    end
  end

end
