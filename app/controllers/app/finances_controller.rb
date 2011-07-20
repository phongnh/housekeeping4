class App::FinancesController < ApplicationController
  def index
    @transactions = Transaction.includes(:category, :account).page(params[:page]).per(10)
    @transaction = Transaction.new
  end

  def create
    redirect_to :action => :index
  end
end

