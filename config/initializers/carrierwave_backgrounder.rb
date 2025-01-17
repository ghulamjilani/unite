# frozen_string_literal: true

CarrierWave::Backgrounder.configure do |c|
  # c.backend :delayed_job, queue: :carrierwave
  # c.backend :resque, queue: :carrierwave
  c.backend :sidekiq, queue: :carrierwave
  # c.backend :girl_friday, queue: :carrierwave
  # c.backend :sucker_punch, queue: :carrierwave
  # c.backend :qu, queue: :carrierwave
  # c.backend :qc
end

CarrierWave.configure do |config|
  config.asset_host = ENV['ASSET_HOST']
end
