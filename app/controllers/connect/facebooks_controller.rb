class Connect::FacebooksController < ApplicationController
  skip_before_action :require_approved_access
  before_action :require_anonymous_access

  def create
    authenticate Connect::Facebook.authenticate(cookies)
    logged_in!
  rescue ActiveRecord::RecordInvalid
    redirect_to root_url, flash: {
      warning: 'FB Permission Missing'
    }
  rescue => e
    redirect_to root_url, flash: {
      warning: 'FB Login Failed'
    }
  end
end
