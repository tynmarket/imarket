module Utils
  module UtilMethod
    def production?
      ENV["RAILS_ENV"] == "production"
    end

    def development?
      ENV["RAILS_ENV"] == "development"
    end
  end
end
