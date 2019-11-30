defmodule PetinderChatWeb.GeneralChannel do
  use PetinderChatWeb, :channel

  def join("general:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (general:lobby).
  def handle_in("shout", payload, socket) do
    spawn(PetinderChat.Conversations, :create_message, [payload])
    broadcast!(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    messages =
      PetinderChat.Conversations.list_messages()
      |> Enum.map(fn(%{message: message, name: name}) -> %{message: message, name: name} end)
    push socket, "messages_history", %{messages: messages}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end


