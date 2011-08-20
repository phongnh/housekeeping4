class App::AccountsController < AppController
  def index
    @accounts = Account.includes(:owner).order([:owner_id, :name]).
                        page(params[:page]).per(10)
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
      @accounts = Account.includes(:owner).order([:owner_id, :name]).
                          page(params[:page]).per(10)
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
    @account.destroy
    redirect_to app_accounts_path
  end

  def delete
    @accounts = Accound.where :id => params[:ids]
    @accounts.each(&:destroy)
    redirect_to app_accounts_path
  end
end

