class PayoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    @payouts = current_user.payouts
  end

  def new
    @payout = current_user.payouts.new
  end

  def create
    @payout = current_user.payouts.new(payout_params)
    if @payout.save
      redirect_to dashboard_users_path, notice: 'Payout was successfully created.'
    else
      render :new
    end
  end

  private

  def payout_params
    params.require(:payout).permit(:amount, :foreign, :currency)
  end
end
