require "/Users/ZC-KanwardeepS/Documents/books/redis_essentials/learning_redis/queue"

class Producer
	def initializer()
	
	end
	def create_messages(number)
		@redis = Redis.new
		@queue = Queue.new("logs")
		for i in 0..number do
			@queue.push("Hello world #"+i.to_s)
		end
		puts "Created "+number.to_s+" logs"
	end
end

producer = Producer.new
producer.create_messages(5)