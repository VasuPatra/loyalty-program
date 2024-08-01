class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum tier: { standard: 0, gold: 1, platinum: 2 }

  validates :dob, presence: true
  validate :valid_dob

  private

  def valid_dob
    return unless dob.present? && dob > Time.zone.today

    errors.add(:dob, "can't be in the future")
  end
end
