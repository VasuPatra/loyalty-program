# Create Users
users = User.create!([
  { name: 'Alice Johnson', email: 'alice@example.com', password: 'password123', dob: '1985-05-15' },
  { name: 'Bob Smith', email: 'bob@example.com', password: 'password123', dob: '1990-07-22' },
  { name: 'Carol Davis', email: 'carol@example.com', password: 'password123', dob: '1988-12-30' }
])

# Create Rewards
rewards = Reward.create!([
  { name: 'Free Coffee', description: 'A voucher for a free coffee', reward_type: 'Free Cofee', condition: 'Accumulate 100 points in one calendar month', expiry_date: nil },
  { name: '5% Cash Rebate', description: '5% cash rebate on transactions', reward_type: 'Cash Back', condition: '10 transactions > $100', expiry_date: nil },
  { name: 'Free Movie Tickets', description: 'Two free movie tickets', reward_type: 'Movie Tickets', condition: 'Spend > $1000 within 60 days of first transaction', expiry_date: nil },
  { name: 'Airport Lounge Access', description: 'Access to airport lounges', condition: 'Gold tier customer', expiry_date: nil }
])

# Create Payouts
payouts = Payout.create!([
  { amount: 120.00, currency: 'INR', foreign: false, user: users[0] },
  { amount: 250.00, currency: 'USD', foreign: true, user: users[1] },
  { amount: 300.00, currency: 'INR', foreign: false, user: users[2] }
])

# Create Points
Point.create!([
  { value: 10, payout: payouts[0], user: users[0] },
  { value: 40, payout: payouts[1], user: users[1] },
  { value: 30, payout: payouts[2], user: users[2] }
])

# Create User Rewards
UserReward.create!([
  { user: users[0], reward: rewards[0], issued_at: Time.now },
  { user: users[1], reward: rewards[1], issued_at: Time.now },
  { user: users[2], reward: rewards[2], issued_at: Time.now }
])

puts "Seed data has been created successfully!"
