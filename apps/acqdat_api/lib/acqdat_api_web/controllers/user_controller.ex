defmodule AcqdatApiWeb.UserController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.User
  alias AcqdatCore.Model.User, as: UserModel
  import AcqdatApiWeb.Helpers

  plug :load_user when action in [:update]

  def show(conn, %{"id" => id}) do
    case conn.status do
      nil ->
        {id, _} = Integer.parse(id)

        with {:show, {:ok, user}} <- {:show, User.get(id)} do
          conn
          |> put_status(200)
          |> render("user_details.json", %{user_details: user})
        else
          {:show, {:error, message}} ->
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
        case UserModel.update(conn.assigns.user, params) do
          {:ok, user} ->
            conn
            |> put_status(200)
            |> render("user_details.json", %{user_details: user})

          {:error, digital_twin} ->
            error = extract_changeset_error(digital_twin)

            conn
            |> send_error(400, error)
        end

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end

  defp load_user(%{params: %{"id" => id}} = conn, _params) do
    {id, _} = Integer.parse(id)

    case UserModel.get(id) do
      {:ok, user} ->
        assign(conn, :user, user)

      {:error, _message} ->
        conn
        |> put_status(404)
    end
  end
end
