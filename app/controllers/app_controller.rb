class AppController < ApplicationController
  before_filter :authenticate_user!

  layout "app"

  private

  # Overwriting the sign_out redirect path method
  #def after_sign_out_path_for(resource_or_scope)
    #app_root_path
  #end

end
