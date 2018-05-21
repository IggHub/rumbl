defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
          |> put_flash(:info, "Welcome back!")
          |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
          |> put_flash(:error, "Error, invalid username/ password")
          |> render("new.html") 
    end
  end 
end
