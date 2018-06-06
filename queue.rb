require "redis"
class Queue
	def initialize(queueName)
		@redis = Redis.new
		@queue_key = "queues:"+queueName
	end

	def push(data)
		@redis.lpush(@queue_key,data)
	end

	def pop()
		@redis.brpop(@queue_key,0)
	end

	def size()
		@redis.llen(@queue_key)
	end
end