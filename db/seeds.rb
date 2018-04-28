User.all.clear
Tweet.all.clear

a = User.create(username: "bob01", email: "bob01.com", password: "bob01")
b = User.create(username: "bob02", email: "bob02.com", password: "bob02")
c = User.create(username: "bob03", email: "bob03.com", password: "bob03")
d = User.create(username: "bob04", email: "bob04.com", password: "bob04")
e = User.create(username: "bob05", email: "bob05.com", password: "bob05")
f = User.create(username: "bob06", email: "bob06.com", password: "bob06")
g = User.create(username: "bob07", email: "bob07.com", password: "bob07")
h = User.create(username: "bob08", email: "bob08.com", password: "bob08")
i = User.create(username: "bob09", email: "bob09.com", password: "bob09")
j = User.create(username: "bob10", email: "bob10.com", password: "bob10")
k = User.create(username: "bob11", email: "bob11.com", password: "bob11")
l = User.create(username: "bob12", email: "bob12.com", password: "bob12")
m = User.create(username: "bob13", email: "bob13.com", password: "bob13")
n = User.create(username: "bob14", email: "bob14.com", password: "bob14")
o = User.create(username: "bob15", email: "bob15.com", password: "bob15")

a.tweets << Tweet.new(content: "This is my tweet!")
b.tweets << Tweet.new(content: "This is my tweet!")
c.tweets << Tweet.new(content: "This is my tweet!")
d.tweets << Tweet.new(content: "This is my tweet!")
e.tweets << Tweet.new(content: "This is my tweet!")
f.tweets << Tweet.new(content: "This is my tweet!")
g.tweets << Tweet.new(content: "This is my tweet!")
h.tweets << Tweet.new(content: "This is my tweet!")
i.tweets << Tweet.new(content: "This is my tweet!")
j.tweets << Tweet.new(content: "This is my tweet!")
k.tweets << Tweet.new(content: "This is my tweet!")
l.tweets << Tweet.new(content: "This is my tweet!")
m.tweets << Tweet.new(content: "This is my tweet!")
n.tweets << Tweet.new(content: "This is my tweet!")
o.tweets << Tweet.new(content: "This is my tweet!")

a.tweets << Tweet.new(content: "This is my second tweet!")
b.tweets << Tweet.new(content: "This is my second tweet!")
c.tweets << Tweet.new(content: "This is my second tweet!")
d.tweets << Tweet.new(content: "This is my second tweet!")
e.tweets << Tweet.new(content: "This is my second tweet!")
f.tweets << Tweet.new(content: "This is my second tweet!")
g.tweets << Tweet.new(content: "This is my second tweet!")
h.tweets << Tweet.new(content: "This is my second tweet!")
i.tweets << Tweet.new(content: "This is my second tweet!")
j.tweets << Tweet.new(content: "This is my second tweet!")
k.tweets << Tweet.new(content: "This is my second tweet!")
l.tweets << Tweet.new(content: "This is my second tweet!")
m.tweets << Tweet.new(content: "This is my second tweet!")
n.tweets << Tweet.new(content: "This is my second tweet!")
o.tweets << Tweet.new(content: "This is my second tweet!")

a.tweets << Tweet.new(content: "This is my third tweet, baby!")
b.tweets << Tweet.new(content: "This is my third tweet, baby!")
c.tweets << Tweet.new(content: "This is my third tweet, baby!")
d.tweets << Tweet.new(content: "This is my third tweet, baby!")
e.tweets << Tweet.new(content: "This is my third tweet, baby!")
f.tweets << Tweet.new(content: "This is my third tweet, baby!")
g.tweets << Tweet.new(content: "This is my third tweet, baby!")
h.tweets << Tweet.new(content: "This is my third tweet, baby!")
i.tweets << Tweet.new(content: "This is my third tweet, baby!")
j.tweets << Tweet.new(content: "This is my third tweet, baby!")
k.tweets << Tweet.new(content: "This is my third tweet, baby!")
l.tweets << Tweet.new(content: "This is my third tweet, baby!")
m.tweets << Tweet.new(content: "This is my third tweet, baby!")
n.tweets << Tweet.new(content: "This is my third tweet, baby!")
o.tweets << Tweet.new(content: "This is my third tweet, baby!")

a.tweets << Tweet.new(content: "This is my last tweet, probably.")
b.tweets << Tweet.new(content: "This is my last tweet, probably.")
c.tweets << Tweet.new(content: "This is my last tweet, probably.")
d.tweets << Tweet.new(content: "This is my last tweet, probably.")
e.tweets << Tweet.new(content: "This is my last tweet, probably.")
f.tweets << Tweet.new(content: "This is my last tweet, probably.")
g.tweets << Tweet.new(content: "This is my last tweet, probably.")
h.tweets << Tweet.new(content: "This is my last tweet, probably.")
i.tweets << Tweet.new(content: "This is my last tweet, probably.")
j.tweets << Tweet.new(content: "This is my last tweet, probably.")
k.tweets << Tweet.new(content: "This is my last tweet, probably.")
l.tweets << Tweet.new(content: "This is my last tweet, probably.")
m.tweets << Tweet.new(content: "This is my last tweet, probably.")
n.tweets << Tweet.new(content: "This is my last tweet, probably.")
o.tweets << Tweet.new(content: "This is my last tweet, probably.")

a.save
b.save
c.save
d.save
e.save
f.save
g.save
h.save
i.save
j.save
k.save
l.save
m.save
n.save
o.save
