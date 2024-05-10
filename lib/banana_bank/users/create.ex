defmodule BananaBank.Users.Create do
  alias BananaBank.Users.Users
  alias BananaBank.Repo

  def call(params) do
    params
    |> Users.changeset()
    |> Repo.insert()
  end


end
