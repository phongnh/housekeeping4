class App::TransactionsController < AppController
  def index
    @transactions = Transaction.associated.ordered.page(params[:page]).per(10)
    @transaction = Transaction.new
  end

  def new
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = Transaction.new params[:transaction]
    @transaction.owner = User.first
    @transaction.save_and_update_account!
    redirect_to app_transactions_path
  rescue Exception => ex
    puts ex.message
    puts ex.backtrace
    @transactions = Transaction.associated.ordered.page(params[:page]).per(10)
    render :action => "index"
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      redirect_to app_transactions_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to app_transactions_path
  end

  def delete
    @transactions = Transaction.where :id => params[:id]
    @transactions.each(&:destroy)
    redirect_to app_accounts_path
  end
end
