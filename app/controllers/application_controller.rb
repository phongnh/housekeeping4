require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_filter :logs_params

  helper_method :logs

  def logs(name, var)
    puts "", "================================================================="
    puts "name = #{var.inspect}"
    puts "=================================================================", ""
  end

  protected
  def logs_params
    logs("params", params)
  end
end

