defmodule PetinderChat.Repo do
  use Ecto.Repo,
    otp_app: :petinder_chat,
    adapter: Ecto.Adapters.Postgres
end
