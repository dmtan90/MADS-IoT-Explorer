defmodule AcqdatApiWeb.SensorController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.Sensor
  alias AcqdatApi.Image
  alias AcqdatApi.ImageDeletion
  alias AcqdatCore.Model.Gateway, as: GatewayModel
  alias AcqdatCore.Model.Sensor, as: SensorModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Sensor

  plug :load_sensor when action in [:update, :delete, :show]
  plug :load_gateway when action in [:sensor_by_criteria, :create]

  def show(conn, %{"id" => id}) do
    case conn.status do
      nil ->
        {id, _} = Integer.parse(id)
        {:list, {:ok, sensor}} = {:list, SensorModel.get(id)}

        conn
        |> put_status(200)
        |> render("sensor.json", sensor)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def index(conn, params) do
    changeset = verify_index_params(params)

    case conn.status do
      nil ->
        {:extract, {:ok, data}} = {:extract, extract_changeset_data(changeset)}
        {:list, sensor} = {:list, SensorModel.get_all(data, [:gateway])}

        conn
        |> put_status(200)
        |> render("index.json", sensor)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def sensor_by_criteria(conn, params) do
    case conn.status do
      nil ->
        {:list, sensors_by_criteria} = Sensor.sensor_by_criteria(params)

        conn
        |> put_status(200)
        |> render("sensors_by_criteria_with_preloads.json",
          sensors_by_criteria: sensors_by_criteria
        )

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
              verify_sensor_params(params)

            false ->
              params = add_image_url(conn, params)
              verify_sensor_params(params)
          end

        with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
             {:create, {:ok, sensor}} <- {:create, Sensor.create(data)} do
          conn
          |> put_status(200)
          |> render("sensor.json", %{sensor: sensor})
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

  def update(conn, params) do
    case conn.status do
      nil ->
        %{assigns: %{sensor: sensor}} = conn
        params = Map.put(params, "image_url", sensor.image_url)

        params =
          case is_nil(params["image"]) do
            true ->
              params

            false ->
              add_image_url(conn, params)
          end

        case SensorModel.update(sensor, params) do
          {:ok, sensor} ->
            conn
            |> put_status(200)
            |> render("sensor.json", %{sensor: sensor})

          {:error, sensor} ->
            error = extract_changeset_error(sensor)

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
        case SensorModel.delete(id) do
          {:ok, sensor} ->
            ImageDeletion.delete_operation(sensor, "sensor")

            conn
            |> put_status(200)
            |> render("sensor.json", %{sensor: sensor})

          {:error, sensor} ->
            error = extract_changeset_error(sensor)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp load_sensor(%{params: %{"id" => id}} = conn, _params) do
    {id, _} = Integer.parse(id)

    case SensorModel.get(id) do
      {:ok, sensor} ->
        assign(conn, :sensor, sensor)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end

  defp load_gateway(%{params: %{"gateway_id" => gateway_id}} = conn, _params) do
    {gateway_id, _} = Integer.parse(gateway_id)

    case GatewayModel.get(gateway_id) do
      {:ok, gateway} ->
        assign(conn, :gateway, gateway)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end

  defp add_image_url(conn, %{"image" => image} = params) do
    with {:ok, image_name} <- Image.store({image, "sensor"}) do
      Map.replace!(params, "image_url", Image.url({image_name, "sensor"}))
    else
      {:error, error} -> send_error(conn, 400, error)
    end
  end
end
