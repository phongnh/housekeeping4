class App::AccountsController < AppController
  def index
    @accounts = Account.associated.ordered.page(params[:page])
    @account  = Account.new
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = Account.new(params[:account])
    @account.owner = User.first
    if @account.save
      redirect_to app_accounts_path
    else
      @accounts = Account.associated.ordered.page(params[:page])
      render :action => "index"
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])

    if @account.update_attributes(params[:account])
      redirect_to app_accounts_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.each(&:destroy)
    redirect_to app_accounts_path
  end
end

