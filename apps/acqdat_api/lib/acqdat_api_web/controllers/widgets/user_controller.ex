defmodule AcqdatApiWeb.Widgets.UserController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.Widgets.User
  alias AcqdatCore.Model.User, as: UserModel
  alias AcqdatCore.Model.Widgets.User, as: UserWidgetModel
  alias AcqdatCore.Model.Widgets.Widget, as: WidgetModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Widgets.User

  plug :verify_widget_and_user when action in [:create]
  plug :verify_user when action in [:index]

  def create(conn, params) do
    case conn.status do
      nil ->
        changeset = verify_user_widget_params(params)

        with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
             {:create, {:ok, user_widget}} <- {:create, User.create(data)} do
          conn
          |> put_status(200)
          |> render("user_widget.json", %{user_widget: user_widget})
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

  def index(conn, params) do
    changeset = verify_index_params(params)

    case conn.status do
      nil ->
        {:extract, {:ok, data}} = {:extract, extract_changeset_data(changeset)}
        {:list, user_widget} = {:list, UserWidgetModel.get_all(data, [:user, :widget])}

        conn
        |> put_status(200)
        |> render("index.json", user_widget)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp verify_widget_and_user(
         %{params: %{"widget_id" => widget_id, "user_id" => user_id}} = conn,
         _params
       ) do
    {widget_id, _} = Integer.parse(widget_id)
    {user_id, _} = Integer.parse(user_id)

    case WidgetModel.get(widget_id) do
      {:ok, widget} ->
        case UserModel.get(user_id) do
          {:ok, user} ->
            widget = Map.put_new(widget, :user, user)
            assign(conn, :widget, widget)

          {:error, _message} ->
            conn
            |> put_status(404)
        end

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end

  defp verify_user(
         %{params: %{"user_id" => user_id}} = conn,
         _params
       ) do
    {user_id, _} = Integer.parse(user_id)

    case UserModel.get(user_id) do
      {:ok, user} ->
        assign(conn, :user, user)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end
end
