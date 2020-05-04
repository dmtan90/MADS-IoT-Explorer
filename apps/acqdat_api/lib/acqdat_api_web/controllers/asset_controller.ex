defmodule AcqdatApiWeb.AssetController do
  use AcqdatApiWeb, :controller
  alias AcqdatCore.Model.Asset, as: AssetModel
  import AcqdatApiWeb.Helpers

  plug :load_asset when action in [:show, :update, :delete]

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, _params) do
    case conn.status do
      nil ->
        conn
        |> put_status(200)
        |> render("asset.json", %{asset: conn.assigns.asset})

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def update(conn, params) do
    case conn.status do
      nil ->
        case AssetModel.update(conn.assigns.asset, params) do
          {:ok, asset} ->
            conn
            |> put_status(200)
            |> render("asset.json", %{asset: asset})

          {:error, asset} ->
            error = extract_changeset_error(asset)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def delete(conn, _params) do
    case conn.status do
      nil ->
        case AssetModel.delete(conn.assigns.asset) do
          {_number, nil} ->
            conn
            |> put_status(200)
            |> render("asset.json", %{asset: conn.assigns.asset})
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp load_asset(%{params: %{"id" => id}} = conn, _params) do
    {id, _} = Integer.parse(id)

    case AssetModel.get(id) do
      {:ok, asset} ->
        assign(conn, :asset, asset)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end
end
