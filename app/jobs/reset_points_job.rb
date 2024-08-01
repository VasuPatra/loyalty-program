class ResetPointsJob
  include Sidekiq::Worker

  def perform
    User.update(tier: 0, total_points: 0)
  end
end
