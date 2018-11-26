class TransferAccountsUnequalValidator < ActiveModel::Validator
  def validate(transfer)
    if transfer.from_account == transfer.to_account
      transfer.errors[:accounts_equal] << 'transfer accounts cannot be the same'
    end
  end
end