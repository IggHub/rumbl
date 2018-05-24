# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias Rumbl.Repo
alias Rumbl.Category
alias Rumbl.Video
alias Rumbl.User

# Seeding 4 categories
for category <- ~w(Action Drama Comedy Scifi) do
  Repo.get_by(Category, name: category) ||
    Repo.insert!(%Category{name: category})
end

# Seeding 3 users
for user <- ~w(iggy1 iggy2 iggy3) do
  Repo.insert!(%User{name: user, username: user, password_hash: Comeonin.Bcrypt.hashpwsalt("password")})
end

# Seeding each user with a video
users = Repo.all User
vid_url = "https://www.youtube.com/watch?v=gO8N3L_aERg&t=196s"
vid_url_2 = "https://www.youtube.com/watch?v=a7RoP1LKMeM"
Enum.each users, fn user ->
  Repo.insert!(%Video{title: "test vid", url: vid_url, description: "test desc", user_id: user.id})
  Repo.insert!(%Video{title: "test vid2", url: vid_url_2, description: "Prison Mike", user_id: user.id})
end
