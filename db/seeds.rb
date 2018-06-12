User.destroy_all
Tweet.destroy_all

tweets = [
  "4 months ago i quietly left 57 dvds of 'click' at my parents' house and they've still never noticed or mentioned it.",
  "waiter, there's a reflection of a sad and lonely man in my soup",
  "Relationships are mostly you apologizing for saying something hilarious",
  "I hate when the other guy goes for a handshake and I go for an open-mouth kiss and oh great now I probably didn't get this job",
  "Leaving my browser history open in case anyone in this coffee shop tries to steal my laptop when I'm in the bathroom. ",
  "I keep a baseball bat under my bed in case someone tries to break in and pitch a no hitter",
  "I guess I prefer Subway because they make me feel like I'm making the healthy decision when I order a loaf of bread with 18 meatballs on it.",
  "Sex is like pizza, if you're going to use bbq sauce you better know what the fuck you're doing",
  "A TV weatherman who keeps accidentally calling the anchorwoman mom",
  "Sex is a lot like Mario Kart, you go really fast, you throw some bananas, Wario is there.",
  "I want a lady in the streets and a lady in the sheets and 2 ladies flanking the east tower. Hold for my signal. We're gonna get that bastard",
  "I always see homeless people walking around with cups of change. I bet they could afford a house if they werent drinking money all the time."
]
users = ["jughead", "betty", "veronica", "archie", "cheryl", "javier"]

# Accepts a array of user strings, tweet strings, and relates x int of tweets to each user
def seed(tweets, users, tweets_per_user)

  tweets.each do |tweet|
    Tweet.create(:content => tweet)
  end

  users.each do |user|
    inst = User.create(username: user, email: "#{user}@mail.com", password: "#{user}@pass.com")
    tweets_per_user.times{inst.tweets << Tweet.all.shuffle.first}
  end

  p "Created #{Tweet.count} Tweets and #{User.count} Users."
end

seed(tweets, users, 2)
