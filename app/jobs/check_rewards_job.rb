class CheckRewardsJob
  include Sidekiq::Worker

  def perform
    User.find_each do |user|
      create_free_coffee_reward(user)
      create_cash_rebate_reward(user)
    end
  end

  private

  def create_free_coffee_reward(user)
    start_date = Time.zone.today
    previous_month = start_date << 1
    current_month = start_date.month

    return unless user.points_in_month(previous_month) >= 100 || user.dob.month == current_month

    UserReward.create!(user:, reward: free_coffee_reward, issued_at: Time.current)
  end

  def create_cash_rebate_reward(user)
    retunr unless user.qualifying_transactions_count >= 10

    UserReward.create!(user:, reward: cash_rebate_reward, issued_at: Time.current)
  end

  def free_coffee_reward
    @free_coffee_reward ||= Reward.find_or_create_by!(reward_type: 'Free Coffee') do |reward|
      reward.description = 'Free Coffee Reward'
    end
  end

  def cash_rebate_reward
    @cash_rebate_reward ||= Reward.find_or_create_by!(reward_type: 'Cash Rebate') do |reward|
      reward.description = '5% Cash Rebate'
    end
  end
end
