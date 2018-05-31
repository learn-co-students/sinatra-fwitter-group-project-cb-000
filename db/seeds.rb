User.destroy_all
Tweet.destroy_all

## users
nova = User.create(username: "nova", email: "novacane@example.com", password: "northoftahoe44")

astro = User.create(username: "astro", email: "astrotwink@example.com",  password: "bawsedaddy415")

thotiana = User.create(username: "thotiana", email: "youngthoti@example.com", password: "millicentmarie")

## tweets
tweet_1 = Tweet.create(content: "Sorry I yelled 'killing it' when your mom was eating that banana.")

tweet_2 = Tweet.create(content: "FAKE BREEDS I'VE TOLD PEOPLE MY DOG IS AT THE DOG PARK: Venetian Dabney, Brown Feta, Waxbeard, Oxnard Pike, Blue Hustler, High Presbyterian")

tweet_3 = Tweet.create(content: "Sick of having to go to 2 different huts to buy pizza & sunglasses.")

tweet_4 = Tweet.create(content: "STOP TELLING ME YOUR NEWBORN'S WEIGHT AND LENGTH I DON'T KNOW WHAT TO DO WITH THAT INFORMATION.")

tweet_5 = Tweet.create(content: "Ladies call me Subway because I've got low quality meat and lie about being 6 inches")

## associations
nova.tweets << tweet_1 << tweet_2
astro.tweets << tweet_3 << tweet_4
thotiana.tweets << tweet_5

p "Created #{User.count} users and #{Tweet.count} tweets."
