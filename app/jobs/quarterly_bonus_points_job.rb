class QuarterlyBonusPointsJob
  include Sidekiq::Worker

  def perform
    start_date = Time.zone.today.beginning_of_quarter
    end_date = Time.zone.today.end_of_quarter

    User.find_each do |user|
      total_spending = user.payouts.where('created_at BETWEEN ? AND ?', start_date, end_date).sum(:amount)

      if total_spending > 2000
        user.update(total_points: total_points + 100)
      end
    end
  end
end
