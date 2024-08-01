class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum tier: { standard: 0, gold: 1, platinum: 2 }

  # Associations
  has_many :payouts, dependent: :destroy
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :points, dependent: :destroy

  # Validations
  validates :dob, presence: true
  validate :valid_dob

  def points_in_month(date)
    points.where(created_at: date.beginning_of_month..date.end_of_month).sum(:value)
  end

  def qualifying_transactions_count(date)
    payouts.where(created_at: date.beginning_of_month..date.end_of_month).where('amount > ?', 100).count
  end

  def total_spending_within(start_date, end_date)
    payouts.where(created_at: start_date..end_date).sum(:amount)
  end

  def update_tier
    new_tier = user_tier

    return unless tier != new_tier

    update(tier: new_tier)
  end

  private

  def valid_dob
    return unless dob.present? && dob > Time.zone.today

    errors.add(:dob, "can't be in the future")
  end

  def user_tier
    case total_points
    when 5000..Float::INFINITY
      2
    when 1000..4999
      1
    else
      0
    end
  end

  def check_and_issue_airport_lounge_reward
    return unless tier.gold? tier_changed?(from: 0, to: 1)

    airport_lounge_reward = Reward.find_or_created_by(reward_type: '4x Airport Lounge Access')
    UserReward.create!(user: self, reward: airport_lounge_reward, issued_at: Time.current)
  end
end
