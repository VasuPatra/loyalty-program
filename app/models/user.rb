class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum tier: { standard: 0, gold: 1, platinum: 2 }

  # Associations
  has_many :payouts, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :user_rewards, dependent: :destroy
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

  private

  def valid_dob
    return unless dob.present? && dob > Time.zone.today

    errors.add(:dob, "can't be in the future")
  end
end
