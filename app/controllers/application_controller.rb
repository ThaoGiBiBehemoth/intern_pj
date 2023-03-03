class ApplicationController < ActionController::Base
  # def hello
  #   render html: "Hello! I'm Thảo GiBi "
  # end

  include SessionsHelper
  private
    # Confirms a logged-in user.
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
