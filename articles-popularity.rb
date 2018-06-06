require "redis"
class Article
	def initialize()
		@redis  = Redis.new
	end
def up_vote(id)
	key = "article:"+id.to_s+":votes"
	@redis.incr(key)
end

def down_vote(id)
	key = "article:"+id.to_s+":votes"
	@redis.decr(key)
end

def show_results(id)
	headline_key = "article:"+id.to_s+":headline"
	vote_key = "article:"+id.to_s+":votes"
	headline = @redis.get(headline_key)
	votes = @redis.get(vote_key)
	puts("Article with headline "+headline+" got - " +votes+"votes")
end

def create_article(id,headline)
	headline_key = "article:"+id.to_s+":headline"
	@redis.set(headline_key,headline)
end
end
article = Article.new
article.create_article("1","google is big")
article.create_article("2","weather is awesome in blore")
article.up_vote(1)
article.up_vote(1)
article.down_vote(1)
article.up_vote(2)
article.up_vote(2)
article.up_vote(2)
article.show_results(1)
article.show_results(2)

