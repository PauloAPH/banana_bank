defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias Users.User

  setup do
    params = %{
      "name" => "Joao",
      "cep" => "09280360",
      "email" => "paulo@test.com",
      "password" => "09280360"
    }

    body =  %{
      "bairro" => "Parque das Nacoes",
      "cep" => "09280-360",
      "complemento" => "",
      "ddd" => "11",
      "gia" => "6269",
      "ibge" => "3547809",
      "localidade" => "Santo Andre",
      "logradouro" => "Rua Grecia",
      "siafi" => "7057",
      "uf" => "SP"
    }

    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "successfully creates an user", %{conn: conn, body: body, user_params: params} do

      expect(BananaBank.ViaCep.ClientMock, :call, fn "09280360" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

        assert %{
          "data" => %{"cep" => "09280360", "email" => "paulo@test.com", "id" => _id, "name" => "Joao"},
          "message" => "User criado com sucesso"
          } = response
    end
  end

  describe "delete/2" do
    test "successfully delete an user", %{conn: conn, body: body, user_params: params} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "09280360" ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

        assert %{
          "data" => %{"cep" => "09280360", "email" => "paulo@test.com", "id" => _id, "name" => "Joao"},
          "message" => "Usuario deletado"
          } = response
    end

  end

end
