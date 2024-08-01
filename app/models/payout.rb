class Payout < ApplicationRecord
  belongs_to :user
  has_one :point, dependent: :destroy

  after_commit :create_point_record, on: :create

  private

  def create_point_record
    earned_points = calculate_points
    Point.create!(user:, payout: self, value: earned_points)
  end

  def calculate_points
    points = (amount / 100).to_i * 10
    points *= 2 if foreign_transaction?
    points
  end

  def foreign_transaction?
    foreign
  end
end
