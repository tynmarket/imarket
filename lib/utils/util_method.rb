module Utils
  module UtilMethod
    include Constants

    def date_spider_start
      DATE_SPIDER_START
    end

    def production?
      ENV["RAILS_ENV"] == "production"
    end

    def development?
      ENV["RAILS_ENV"] == "development"
    end
  end
end
