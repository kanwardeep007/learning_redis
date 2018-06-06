require "/Users/ZC-KanwardeepS/Documents/books/redis_essentials/learning_redis/queue"

class Consumer
	def initialize()
		@redis = Redis.new
		@queue = Queue.new("logs")
	end

	def consume_messages()
		while 2<3 do
			puts(@queue.pop)
		end
	end
end

consumer = Consumer.new()
consumer.consume_messages