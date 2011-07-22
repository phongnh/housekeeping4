class App::DashboardController < ApplicationController
  def index
    @summary = Transaction.summary(Account.first)
  end

end

