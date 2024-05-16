defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BananaBank.Accounts.Account

  @requiredParamsCreate [:name, :password, :email, :cep]
  @requiredParamsUpdate [:name, :email, :cep]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string
    has_one :account, Account
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @requiredParamsCreate)
    |> doValidation(@requiredParamsCreate)
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @requiredParamsCreate)
    |> doValidation(@requiredParamsUpdate)
    |> add_password_hash()
  end


  defp doValidation(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> validate_length(:password, min: 6)
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset
end
