class Payout < ApplicationRecord
  belongs_to :user
  has_one :point, dependent: :destroy

  after_commit :create_point_record, :check_and_issue_free_movie_tickets, on: :create

  private

  def check_and_issue_free_movie_tickets
    first_transaction_date = user.payouts.minimum(:created_at)

    return unless first_transaction_date >= 60.days.ago

    end_date = first_transaction_date + 60.days
    spending = user.total_spending_within(first_transaction_date, end_date)

    return unless spending > 1000

    UserReward.create!(user:, reward: free_movie_tickets_reward, issued_at: Time.current)
  end

  def free_movie_tickets_reward
    @free_movie_tickets_reward ||= Reward.find_or_create_by(reward_type: 'Free Movie Ticket')
  end

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
