class PagesController < ApplicationController
  before_action :fetch_transactions, only: :home

  def home
  end

  private

  def fetch_transactions
    @transactions ||= current_user.credits.map do |c|
      { transaction_type: :credit, created_at: c.created_at, amount: c.amount }
    end.sort { |l, r| r[:created_at] <=> l[:created_at] }
  end
end
