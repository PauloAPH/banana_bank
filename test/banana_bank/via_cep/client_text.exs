defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = "09280360"

      body = ~s({
        "bairro": "Parque das Nacoes",
        "cep": "09280-360",
        "complemento": "",
        "ddd": "11",
        "gia": "6269",
        "ibge": "3547809",
        "localidade": "Santo Andre",
        "logradouro": "Rua Grecia",
        "siafi": "7057",
        "uf": "SP"
      })

      expected_response =
        {:ok,
          %{
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
          }}

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"

end
