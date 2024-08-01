class Point < ApplicationRecord
  belongs_to :payout
  belongs_to :user

  after_create :update_user_total_points

  private

  def update_user_total_points
    user.update(total_points: user.total_points + value)
  end
end
