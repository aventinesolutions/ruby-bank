class AccountChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel_handle
  end

  def send_transaction(payload)
    ActionCable.server.broadcast channel_handle, account: render(current_user.account)
  end

  private

  def channel_handle
    "account_#{current_user.email}"
  end
end
