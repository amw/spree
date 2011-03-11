class AuthHooks < Spree::ThemeSupport::HookListener
  insert_after :checkout_shipping_address,
    :partial => "checkout/save_user_addresses"
end
