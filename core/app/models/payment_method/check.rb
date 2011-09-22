class PaymentMethod::Check < PaymentMethod
  def allows_confirmation?
    true
  end
end
