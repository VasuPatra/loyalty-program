class Point < ApplicationRecord
  belongs_to :payout
  belongs_to :user
end
