class App::DashboardController < AppController

  def index
    @account_summaries, @summaries = current_user.account_summary
    @transactions = Transaction.where(:account_id => @account_summaries.keys).news
  end

end

