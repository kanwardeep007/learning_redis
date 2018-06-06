require "redis"

class VoteSystem
  def initialize()
    @redis = Redis.new
  end

  def save_link(id,author,title,link)
    @redis.hmset("id:" + id,"author",author,"title",title,"link",link,"score",0)
  end

  def upvote(id)
    @redis.hincrby("id:"+id,"score",1)
  end

  #hash doesnt have decrement
  def downvote(id)
    @redis.hincrby("id:"+id,"score",-1)
  end

  def show_details(id)
    replies = @redis.hgetall("id:"+id)
    print("Title:", replies['title'])
    puts("")
    print("Author:", replies['author'])
    puts("")
    print("Link:", replies['link'])
    puts("")
    print("Score:", replies['score'])
    puts("")
    puts("--------------------------")
  end
end

s = VoteSystem.new
s.save_link("123", "dayvson", "Maxwell Dayvson's Github page", "https://github.com/dayvson");
s.save_link("456", "hltbra", "Hugo Tavares's Github page", "https://github.com/hltbra");

s.upvote("123")
s.upvote("123")
s.upvote("456")
s.show_details("123")
s.show_details("456")
