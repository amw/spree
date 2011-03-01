class UsersController < Spree::BaseController
  resource_controller

  ssl_required :new, :create, :edit, :update, :show

  actions :all, :except => [:index, :destroy]

  show.before do
    @orders = @user.orders.complete
  end

  create.after do
    associate_user
  end

  create.flash nil
  create.wants.html { redirect_back_or_default(root_url) }

  new_action.before do
    flash.now[:notice] = I18n.t(:please_create_user) unless User.admin_created?
  end

  update.wants.html { redirect_to account_url }
  update.flash { I18n.t("account_updated") }
  update.failure.wants.html do
    if params[:user][:bill_address_attributes].present?
      render 'address'
    else
      render 'edit'
    end
  end

  def address
    @user ||= current_user
    authorize! :update, @user

    @user.bill_address ||= Address.new :country_id => Spree::Config[:default_country_id]
    @user.ship_address ||= Address.new :country_id => Spree::Config[:default_country_id]
  end

  private
  def object
    @object ||= current_user
  end

  def accurate_title
    I18n.t(:account)
  end

  def associate_user
    return unless current_order and @user.valid?
    current_order.associate_user!(@user)
    session[:guest_token] = nil
  end

end

