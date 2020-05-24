defmodule AcqdatApiWeb.AuthorizationPlug do
  # use Guardian.Plug.Pipeline,
  #   otp_app: :acqdat_api,
  #   module: AcqdatApiWeb.Guardian,
  #   error_handler: AcqdatApiWeb.ErrorHandler

  # use AcqdatApiWeb, :controller

  import Plug.Conn
  import AcqdatApiWeb.Helpers

  @doc false
  @spec init(any()) :: any()
  def init(config), do: config

  @doc false
  @spec call(Conn.t(), atom()) :: Conn.t()

  def call(conn, _options) do
    controller = to_string(conn.private.phoenix_controller)
    action = to_string(conn.private.phoenix_action)

    user_role = load_role(conn)

    if accessible?(user_role, controller, action) do
      conn
    else
      conn
      |> send_error(404, "you are unauthorized to access this!")
      |> halt()
    end
  end

  defp accessible?(nil, _, _), do: false

  defp accessible?("admin", _, _), do: true

  defp accessible?(user_role, controller, action)
       when user_role == "member" and
              controller == "Elixir.AcqdatApiWeb.EntityManagement.AssetController" do
    if action == "show" do
      true
    else
      false
    end
  end

  defp accessible?(user_role, controller, action)
       when user_role == "member" and
              controller == "Elixir.AcqdatApiWeb.EntityManagement.EntityController" do
    if action == "fetch_hierarchy" do
      true
    else
      false
    end
  end

  defp accessible?(user_role, controller, action)
       when user_role == "member" and
              controller == "Elixir.AcqdatApiWeb.EntityManagement.OrganisationController" do
    if Enum.member?(["show", "get_apps"], action) do
      true
    else
      false
    end
  end

  defp accessible?(user_role, controller, action)
       when user_role == "member" and
              controller == "Elixir.AcqdatApiWeb.EntityManagement.SensorController" do
    if Enum.member?(["show", "index"], action) do
      true
    else
      false
    end
  end

  defp accessible?(user_role, controller, _action) when user_role == "member" do
    if Regex.match?(~r/Elixir.AcqdatApiWeb.RoleManagement/, controller) do
      false
    else
      true
    end
  end

  # TODO: For Manager Role
  # defp accessible?("manager", _, _, conn) do
  # end

  defp load_role(conn) do
    current_user = conn.assigns[:current_user]
    current_user.role.name
  end
end
