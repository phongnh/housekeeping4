class App::TransactionsController < AppController

  before_filter :validate_params, :only => [ :destroy ]

  def index
    prepare_data
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
    prepare_data
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
    # Account is 'all' account
    transactions =
      if params[:account_id].to_i == 0
        Transaction
      else
        Transaction.where :account_id => params[:account_id]
      end
    transactions = transactions.find Array(params[:id])
    transactions.each(&:destroy_and_update_account!)
    #redirect_to app_transactions_path
    redirect_to request.referer
  end

  private

  def validate_params
    redirect_to request.referer and return if Array(params[:id]).empty?
  end

  def prepare_data
    @accounts, @transactions = Transaction.by_account_id(params)
  end
end
