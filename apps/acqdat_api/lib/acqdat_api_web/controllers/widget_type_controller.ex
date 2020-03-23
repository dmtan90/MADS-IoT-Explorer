defmodule AcqdatApiWeb.WidgetTypeController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.WidgetType
  alias AcqdatCore.Model.WidgetType, as: WTModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.WidgetType

  plug :load_widget_type when action in [:update, :show, :delete]

  def create(conn, params) do
    changeset = verify_widget_type_params(params)

    with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
         {:create, {:ok, widget_type}} <- {:create, WidgetType.create(data)} do
      conn
      |> put_status(200)
      |> render("widget_type.json", %{widget_type: widget_type})
    else
      {:extract, {:error, error}} ->
        send_error(conn, 400, error)

      {:create, {:error, message}} ->
        send_error(conn, 400, message)
    end
  end

  defp load_widget_type(conn, params) do
  end
end
