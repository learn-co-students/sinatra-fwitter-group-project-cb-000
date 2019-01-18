leffen = User.new
leffen.email = "Big_Leff@tsm.com"
leffen.username = "Wumbo_William"
leffen.password = "TSM"
leffen.save
research = Tweet.create(content: "Yeah I'm a smash player and...", user_id: leffen.id)
