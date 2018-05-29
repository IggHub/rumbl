defmodule Rumbl.AuthTest do
  use Rumbl.ConnCase
  alias Rumbl.Auth

  setup %{conn: conn} do
    conn = conn 
            |> bypass_through(Rumbl.Router, :browser)
            |> get("/")

    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current user exists", %{conn: conn} do
    conn = Auth.authenticate_user(conn, [])
    assert conn.halted
  end

  test "authenticate_user continues when the current user exists", %{conn: conn} do
    conn =
      conn
      |> assign(:current_user, %Rumbl.User{})
      |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login puts the user in current_user", %{conn: conn} do
    login_conn = conn
                  |> Auth.login(%Rumbl.User{id: 123})
                  |> send_resp(:ok, "")
    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 123 
  end
end