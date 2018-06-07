defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join("videos:" <> video_id, _params, socket) do 
    {:ok, socket}
  end

  def join(_channel, _params, _socket) do
    {:error, %{reason: "no channel found"}}
  end

  def handle_in("new_annotation", params, socket) do
    broadcast! socket, "new_annotation", %{
      user: %{username: "anon"}, 
      body: params["body"],
      at: params["at"]
    }
    {:reply, :ok, socket} 
  end
end
