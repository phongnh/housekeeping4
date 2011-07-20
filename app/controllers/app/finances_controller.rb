class App::FinancesController < ApplicationController
  def index
    @transactions = Transaction.includes(:category, :account).page(params[:page]).per(10)
  end
end

