User.destroy_all
Tweet.destroy_all

tweets = [
  Tweet.create(:content => "4 months ago i quietly left 57 dvds of 'click' at my parents' house and they've still never noticed or mentioned it."),
  Tweet.create(:content => "waiter, there's a reflection of a sad and lonely man in my soup"),
  Tweet.create(:content => "Relationships are mostly you apologizing for saying something hilarious"),
  Tweet.create(:content => "I hate when the other guy goes for a handshake and I go for an open-mouth kiss and oh great now I probably didn't get this job"),
  Tweet.create(:content => "Leaving my browser history open in case anyone in this coffee shop tries to steal my laptop when I'm in the bathroom. "),
  Tweet.create(:content => "I keep a baseball bat under my bed in case someone tries to break in and pitch a no hitter"),
  Tweet.create(:content => "I guess I prefer Subway because they make me feel like I'm making the healthy decision when I order a loaf of bread with 18 meatballs on it."),
  Tweet.create(:content => "Sex is like pizza, if you're going to use bbq sauce you better know what the fuck you're doing"),
  Tweet.create(:content => "A TV weatherman who keeps accidentally calling the anchorwoman mom"),
  Tweet.create(:content => "Sex is a lot like Mario Kart, you go really fast, you throw some bananas, Wario is there."),
  Tweet.create(:content => "I want a lady in the streets and a lady in the sheets and 2 ladies flanking the east tower. Hold for my signal. We're gonna get that bastard"),
  Tweet.create(:content => "I always see homeless people walking around with cups of change. I bet they could afford a house if they werent drinking money all the time.")
]

astro = User.create(username: "astro", email: "astro@example.com", password: "astropass")
astro.tweets << tweets[0..2]

nova = User.create(username: "nova", email: "nova@example.com", password: "novapass")
nova.tweets << tweets[3..5]

alex = User.create(username: "alex", email: "alex@example.com", password: "alexpass")
alex.tweets << tweets[6..8]

jack = User.create(username: "jack", email: "jack@example.com", password: "jackpass")
jack.tweets << tweets[9..11]

p "Created #{User.count} Users and #{Tweet.count} Tweets."
