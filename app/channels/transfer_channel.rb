class TransferChannel < ApplicationCable::Channel
  def subscribed
    stream_from(channel_name)
  end

  def send_transfer(payload)
    to_account = User.find_by_email(payload['transfer']['email']).account
    transfer = Transfer.new(from_account: current_user.account, to_account: to_account, amount: amount(payload))
    ActionCable.server.broadcast(channel_name, account: render(current_user.account)) if transfer.save
  end

  private

  def amount(payload)
    BigDecimal(payload['transfer']['amount'])
  end

  def channel_name
    "transfer_#{current_user.email}"
  end

  def render(account)
    ApplicationController.new.helpers.c('account', account: account)
  end
end
