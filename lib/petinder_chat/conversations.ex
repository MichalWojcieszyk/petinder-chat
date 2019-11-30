defmodule PetinderChat.Conversations do
  import Ecto.Query, warn: false
  alias PetinderChat.Repo

  alias PetinderChat.Conversations.Message

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def list_messages do
    Repo.all(Message)
  end


end