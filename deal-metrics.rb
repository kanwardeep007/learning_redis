require "redis"
class Deal
	def initialize()
		@redis = Redis.new
	end
	def mark_deal_as_sent(deal_id,user_id)
		@redis.sadd(deal_id,user_id)
	end
	def send_deal_if_not_sent(deal_id,user_id)
		reply = @redis.sismember(deal_id,user_id)
		if reply
			puts("already sent the deal")
		else
			puts("sending the deal to user")
			# code for sending the deal 
			mark_deal_as_sent(deal_id,user_id)
		end
	end
	def show_users_who_received_all_deals(deal_ids)
		reply = @redis.sinter(deal_ids)
		puts(reply.to_s+" received all of the deals "+deal_ids.to_s)
	end
	def show_users_who_received_atleast_one_of_the_deals(deal_ids)
		reply  = @redis.sunion(deal_ids)
		puts(reply.to_s + " received at least one of the deals " + deal_ids.to_s)
	end
end

d = Deal.new
d.mark_deal_as_sent('deal:1', 'user:1');
d.mark_deal_as_sent('deal:1', 'user:2');
d.mark_deal_as_sent('deal:2', 'user:1');
d.mark_deal_as_sent('deal:2', 'user:3');
d.send_deal_if_not_sent('deal:1', 'user:1');
d.send_deal_if_not_sent('deal:1', 'user:2');
d.send_deal_if_not_sent('deal:1', 'user:3');
d.show_users_who_received_all_deals(["deal:1", "deal:2"]);
d.show_users_who_received_atleast_one_of_the_deals(["deal:1", "deal:2"]);