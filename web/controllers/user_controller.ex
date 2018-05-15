defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.User

  def index(conn, _params) do
    users = Repo.all_user User
    render conn, "index.html", users: users
  end

  def show(conn, %{"id"=> id}) do
    user = Repo.get_user User, id
    render conn, "show.html", user: user
  end
end
