user1 = User.create!(username: "liann", password: "liannliann")
user2 = User.create!(username: "sj", password: "sjsjsj")

sub1 = Sub.create!(title: "Aww", description: "Cute Things", moderator_id: user1.id)
sub2 = Sub.create!(title: "Ball is life", moderator_id: user1.id)

post1 = Post.new(title: "sooo cute", url: "http://imgur.com/N3mxeSD", author_id: user1.id)
post2 = Post.new(title: "sooo cute2", url: "http://imgur.com/N3mxeSD", author_id: user2.id)
post3 = Post.new(title: "soooo cute3", content: "you wish you knew", author_id: user1.id)

post1.subs << sub1
post2.subs << sub1
post3.subs << sub2

post1.subs << sub2


postsub1 = post1.post_subs.new(sub_id: sub1.id)
postsub2 = post1.post_subs.new(sub_id: sub2.id)
postsub3 = post2.post_subs.new(sub_id: sub1.id)
postsub3 = post3.post_subs.new(sub_id: sub2.id)

post1.save!
post2.save!
post3.save!
