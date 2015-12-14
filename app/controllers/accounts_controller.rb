class AccountsController < ApplicationController
  before_filter :require_admin_access, except: :index
  before_filter :set_account, except: :index

  def index
    @accounts = Account.all
  end

  def approve
    @account.approve!
    redirect_to accounts_url, flash: {
      success: 'flash.update.success'.t
    }
  end

  private

  def set_account
    @account = Account.find params[:id]
  end
end