defmodule AcqdatApiWeb.Alerts.AlertRulesController do
  @moduledoc """
  ALERT RULES API
  """
  use AcqdatApiWeb, :controller
  alias AcqdatApi.Alerts.AlertRules
  alias AcqdatCore.Alerts.Model.AlertRules, as: ARModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Alerts.AlertRules

  plug AcqdatApiWeb.Plug.LoadProject
  plug AcqdatApiWeb.Plug.LoadOrg

  def create(conn, params) do
    case conn.status do
      nil ->
        changeset = verify_alert_rules(params)

        with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
             {:create, {:ok, alert_rules}} <- {:create, AlertRules.create(data)} do
          conn
          |> put_status(200)
          |> render("alert_rules.json", %{alert_rules: alert_rules})
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
    require IEx
    IEx.pry()
  end

  def delete(conn, params) do
    require IEx
    IEx.pry()
  end

  def show(conn, params) do
    require IEx
    IEx.pry()
  end
end
