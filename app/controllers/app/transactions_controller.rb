class App::TransactionsController < AppController
  def index
    #@accounts = Account.includes(:transactions).all

    #account = @accounts.detect { |a| a.id == params[:account_id].to_i }

    #@accounts.insert 0, Account.new(:name => "Tât cả")
    #if account
      #@transactions = account.transactions.associated.ordered
    #else
      #@transactions = Transaction.associated.ordered
    #end
    @accounts, @transactions = Transaction.by_account_id(params[:account_id])
    @transaction = Transaction.new
  end

  def new
    @transaction = current_user.transactions.build
  end

  def create
    account_id = params[:transaction][:account_id]
    account = Account.find account_id
    @transaction = Transaction.new params[:transaction]
    @transaction.owner = User.first
    @transaction.account = account
    @transaction.save_and_update_account!
    redirect_to app_account_transactions_path(account)
  rescue Exception => ex
    puts ex.message
    puts ex.backtrace
    @accounts, @transactions = Transaction.by_account_id account_id
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
