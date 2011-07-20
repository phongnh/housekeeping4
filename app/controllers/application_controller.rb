require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  #before_filter :inspect_params

  helper_method :log

  def inspect_params
    log("params", params)
  end

  def log(name, var)
    puts "", "================================================================="
    puts "#{name} = #{var.inspect}"
    puts "=================================================================", ""
  end
end

