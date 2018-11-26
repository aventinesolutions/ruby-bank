class PagesController < ApplicationController
  before_action :fetch_transactions, only: :home

  def home
  end

  private

  def fetch_transactions
    @transactions ||= current_user.account.all_transactions
  end
end
