defmodule AcqdatApiWeb.GatewayController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.Gateway
  alias AcqdatApi.Image
  alias AcqdatApi.ImageDeletion
  alias AcqdatCore.Model.Gateway, as: GatewayModel
  alias AcqdatCore.Model.Site, as: SiteModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Gateway

  plug :load_site when action in [:create]
  plug :load_gateway when action in [:update, :delete, :show]

  def index(conn, params) do
    changeset = verify_index_params(params)

    case conn.status do
      nil ->
        {:extract, {:ok, data}} = {:extract, extract_changeset_data(changeset)}
        {:list, gateway} = {:list, GatewayModel.get_all(data, [:site])}

        conn
        |> put_status(200)
        |> render("index.json", gateway)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def create(conn, params) do
    case conn.status do
      nil ->
        params = Map.put(params, "image_url", "")

        changeset =
          case is_nil(params["image"]) do
            true ->
              verify_gateway_params(params)

            false ->
              params = add_image_url(conn, params)
              verify_gateway_params(params)
          end

        with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
             {:create, {:ok, gateway}} <- {:create, Gateway.create(data)} do
          conn
          |> put_status(200)
          |> render("gateway.json", %{gateway: gateway})
        else
          {:extract, {:error, error}} ->
            send_error(conn, 400, error)

          {:create, {:error, message}} ->
            send_error(conn, 400, message)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def show(conn, %{"id" => id}) do
    case conn.status do
      nil ->
        {id, _} = Integer.parse(id)
        {:list, {:ok, gateway}} = {:list, GatewayModel.get(id)}

        conn
        |> put_status(200)
        |> render("gateway.json", gateway)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def update(conn, params) do
    case conn.status do
      nil ->
        %{assigns: %{gateway: gateway}} = conn
        params = Map.put(params, "image_url", gateway.image_url)

        params =
          case is_nil(params["image"]) do
            true ->
              params

            false ->
              add_image_url(conn, params)
          end

        case GatewayModel.update(gateway, params) do
          {:ok, gateway} ->
            conn
            |> put_status(200)
            |> render("gateway.json", %{gateway: gateway})

          {:error, gateway} ->
            error = extract_changeset_error(gateway)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def delete(conn, %{"id" => id}) do
    case conn.status do
      nil ->
        case GatewayModel.delete(id) do
          {:ok, gateway} ->
            ImageDeletion.delete_operation(gateway, "gateway")

            conn
            |> put_status(200)
            |> render("gateway.json", %{gateway: gateway})

          {:error, gateway} ->
            error = extract_changeset_error(gateway)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp load_site(%{params: %{"site_id" => site_id}} = conn, _params) do
    {site_id, _} = Integer.parse(site_id)

    case SiteModel.get(site_id) do
      {:ok, site} ->
        assign(conn, :site, site)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end

  defp add_image_url(conn, %{"image" => image} = params) do
    with {:ok, image_name} <- Image.store({image, "gateway"}) do
      Map.replace!(params, "image_url", Image.url({image_name, "gateway"}))
    else
      {:error, error} -> send_error(conn, 400, error)
    end
  end

  defp load_gateway(%{params: %{"id" => id}} = conn, _params) do
    {id, _} = Integer.parse(id)

    case GatewayModel.get(id) do
      {:ok, gateway} ->
        assign(conn, :gateway, gateway)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end
end
