class PromoHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_tabs do
    %(<%= tab(:promotions) %>)
  end

  insert_after :product_properties, 'products/promotions'

  insert_after :checkout_payment_step, 'checkout/coupon_code'

end
