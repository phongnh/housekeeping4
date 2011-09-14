class App::AccountsController < AppController
  before_filter :validate_params, :only => [:destroy]

  def index
    @accounts = current_user.accounts.associated.ordered.page(params[:page]).all
    @account  = Account.new
  end

  #def new
    #@account = current_user.accounts.build
  #end

  def create
    @account = Account.new(params[:account])
    @account.owner = current_user
    if @account.save
      redirect_to app_accounts_path
    else
      @accounts = current_user.accounts.associated.ordered.page(params[:page]).all
      render :action => "index"
    end
  end

  def edit
    @account = Account.find(params[:id])
    @transactions = @account.transactions.with_categories.ordered.page(params[:page]).all
    @total, @summaries = @account.summary
  end

  def update
    @account = Account.find(params[:id])

    if @account.update_attributes(params[:account])
      #redirect_to app_accounts_path
      redirect_to request.referer
    else
      render :action => "edit"
    end
  end

  def destroy
    Account.find(Array(params[:id])).each(&:destroy)
    redirect_to app_accounts_path
  end

  private

  def validate_params
    redirect_to request.referer and return if Array(params[:id]).empty?
  end
end

