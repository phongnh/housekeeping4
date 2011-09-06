class App::TransactionsController < AppController

  before_filter :validate_params, :only => [ :destroy ]

  def index
    prepare_data
    @transaction = Transaction.new
  end

  #def new
    #@transaction = current_user.transactions.build
  #end

  def create
    account_id = params[:transaction][:account_id]
    @transaction = Transaction.new params[:transaction]
    account = Account.find_by_id account_id
    @transaction.reporter = current_user
    @transaction.account = account
    @transaction.save_and_update_account!
    redirect_to app_account_transactions_path(account)
  rescue Exception => ex
    prepare_data
    render :action => "index"
  end

  #def edit
  #end

  def remote_edit
    @transaction = Transaction.find params[:id]
    render :partial => 'remote_form', :locals => { :transaction => @transaction }
  end

  #def update
    #@transaction = Transaction.find(params[:id])
    #if @transaction.update_attributes(params[:transaction])
      #redirect_to app_transactions_path
    #else
      #render :partial => 'form', :locals => { :transaction => @transaction }
    #end
  #end

  def remote_update
    @transaction = Transaction.find params[:id]
    @transaction.update_and_update_account!(params[:my_transaction])
    render :json => { :status => :success }
  rescue
    render :partial => "remote_form", :locals => { :transaction => @transaction }
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
    @total, @summaries = Transaction.summary(@accounts.map(&:id))
  end
end
