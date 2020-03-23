defmodule AcqdatApiWeb.WidgetController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.Widget
  alias AcqdatCore.Model.Widget, as: WidgetModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Widget

  plug :load_widget when action in [:update, :show, :delete]

  def create(conn, params) do
    changeset = verify_widget_params(params)

    with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
         {:create, {:ok, widget}} <- {:create, Widget.create(data)} do
      conn
      |> put_status(200)
      |> render("widget.json", %{widget: widget})
    else
      {:extract, {:error, error}} ->
        send_error(conn, 400, error)

      {:create, {:error, message}} ->
        send_error(conn, 400, message)
    end
  end

  def show(conn, params) do
    case conn.status do
      nil ->
        conn
        |> put_status(200)
        |> render("widget.json", %{widget: conn.assigns.widget})

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  def delete(conn, params) do
    case conn.status do
      nil ->
        case WidgetModel.delete(conn.assigns.widget) do
          {:ok, widget} ->
            conn
            |> put_status(200)
            |> render("widget.json", %{widget: widget})

          {:error, widget} ->
            error = extract_changeset_error(widget)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp load_widget(%{params: %{"id" => widget_id}} = conn, _params) do
    {widget_id, _} = Integer.parse(widget_id)

    case WidgetModel.get(widget_id) do
      {:ok, widget} ->
        assign(conn, :widget, widget)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end
end
