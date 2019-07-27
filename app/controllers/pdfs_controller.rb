class PdfsController < ApplicationController
  layout "pdf"

  def show
    path = params[:path]
    pdf = path&.split("/")&.last
    @pdf = "#{pdf}.pdf"
    @disclosure = Disclosure.find_by!(pdf: @pdf)

    @code = @disclosure.code
    @title = title
  end

  private

  def title
    "#{@disclosure.name}の#{@disclosure.title} | iMarket（適時開示ネット）"
  end
end
