astro = User.create(username: "Astro", email: "astro@example.com", password: "astropass")
astro.tweets << Tweet.create(content: "Astro tweet one.")
astro.tweets << Tweet.create(content: "Astro tweet two.")

nova = User.create(username: "Thotiana", email: "thoti@example.com", password: "thotipass")
nova.tweets << Tweet.create(content: "Nova tweet one.")
nova.tweets << Tweet.create(content: "Nova tweet two.")

thoti = User.create(username: "Nova", email: "nova@example.com", password: "novapass")
thoti.tweets << Tweet.create(content: "Thotiana tweet one.")
thoti.tweets << Tweet.create(content: "Thotiana tweet two.")

p "Created #{User.count} Users and #{Tweet.count} Tweets!"
