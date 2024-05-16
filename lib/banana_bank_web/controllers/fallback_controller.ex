defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller


  def call({:error, :not_found}, conn) do
    conn
    |> put_status(:not_found)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:error, status: :not_found)
  end

  def call({:error, :bad_request}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call({:error, %Ecto.Changeset{} = changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call({:error,msg}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:error, msg: msg)
  end


end
