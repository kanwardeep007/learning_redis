require "redis"

class Leaderboard
	def initialize(key)
		@redis = Redis.new
		@key = key
	end
	def add_user(name,score)
		@redis.zadd(@key,score,name)
		puts(name+" added to leaderboard")
	end
	def remove_user(name)
		@redis.zrem(@key,name)
		puts(name+" removed successfully")
	end
	def get_user_score_and_rank(name)
		score = @redis.zscore(@key,name)
		rank = @redis.zrevrank(@key,name)
		puts("Details of "+name)
		print("Score: "+score.to_s)
		print(" Rank: #{rank}")
		puts("")
	end
	def show_top_users(number)
		reply = @redis.zrevrange(@key,0,number-1,:with_scores => true)
		puts(reply.to_s)
	end
	def get_users_around_user(name,number)
		rank = @redis.zrevrank(@key,name)
		start_offset = (rank-(number/2)+1).floor
		start_offset = 0 if start_offset < 0
		end_offset = start_offset + number-1
		range_reply = @redis.zrevrange(@key,start_offset,end_offset,:with_scores => true)
		puts(range_reply.to_s)
	end
end
l = Leaderboard.new("game-score")
l.add_user("Arthur", 70)
l.add_user("KC", 20)
l.add_user("ravi", 10)
l.add_user("Maxwell", 10)
l.add_user("Patrik", 30)
l.add_user("Ana", 60);
l.add_user("Felipe", 40);
l.add_user("Renata", 50);
l.add_user("Hugo", 80);
l.remove_user("Arthur")
l.get_user_score_and_rank("Maxwell");
l.show_top_users(3);
l.get_users_around_user("Felipe", 5)