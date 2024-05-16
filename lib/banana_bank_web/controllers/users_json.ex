defmodule BananaBankWeb.UsersJSON do

  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User criado com sucesso",
      data: data(user)
    }
  end

  def delete(%{user: user}), do: %{message: "Usuario deletado", data: data(user)}
  def get(%{user: user}), do: %{data: data(user)}
  def update(%{user: user}), do: %{message: "Atualizado com sucesso", data: data(user)}

  def login(%{token: token}) do
    %{
      message: "User autenticado com sucesso",
      Bearer: token
    }

  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      cep: user.cep,
      email: user.email,
      name: user.name
    }
  end

end
