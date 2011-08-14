class App::FinancesController < ApplicationController
  def index
    @transactions = Transaction.recent.page(params[:page]).per(10)
    @transaction  = Transaction.new
    @summary      = Transaction.summary(Account.first)
    end

  def create
    @transaction         = Transaction.new params[:transaction]
    @transaction.account = Account.first
    @transaction.owner   = User.first
    if @transaction.save
      redirect_to request.referer
    else
      @transactions = Transaction.recent.page(params[:page]).per(10)
      render :action => :index
    end
  end
end

