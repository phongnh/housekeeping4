class App::AccountsController < ApplicationController
  def index
    @accounts = Account.includes(:owner).order([:owner_id, :name]).
                        page(params[:page]).per(10)
  end
end

