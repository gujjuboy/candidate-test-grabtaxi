# Worker classes are normal ruby classes
class SmsJob
  # Just include the Mixin below and the perform_async method will be available
  include Sidekiq::Worker

  def perform(name)
    time = Time.now
    duration = Time.now - time

    text =  "(#{"%.2f" % duration }) #{time.strftime("%F %T")}: Hey #{name}, Has a passenger booked."

    redis.rpush "sms", text
  end

  # Create a redis client
  def redis
    @redis ||= Redis.new
  end
end

