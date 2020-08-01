defmodule AcqdatApiWeb.Alerts.AlertRulesControllerTest do
  @moduledoc """
  Test cases for the API of alertrules endpoints
  """
  use ExUnit.Case, async: true
  use AcqdatApiWeb.ConnCase
  use AcqdatCore.DataCase
  import AcqdatCore.Support.Factory

  @doc """
  test for the creation of alert rule
  """
  describe "create/2" do
    setup :setup_conn
    setup :setup_alert_rules

    test "create alert rule", %{conn: conn, alert_rule: alert_rule, org: org} do
      conn =
        post(
          conn,
          Routes.alert_rules_path(conn, :create, org.id, alert_rule.project.id),
          alert_rule
        )

      response = conn |> json_response(200)
      # TODO: Test needs to be created
    end
  end

  def setup_alert_rules(_context) do
    sensor = insert(:sensor)
    parameters = fetch_parameters(sensor.sensor_type.parameters)
    [user1, user2, user3] = insert_list(3, :user)

    alert_rule = %{
      entity: "sensor",
      entity_id: sensor.id,
      policy_name: "Elixir.AcqdatCore.Alerts.Policies.RangeBased",
      entity_parameters: parameters,
      uuid: UUID.uuid1(:hex),
      communication_medium: ["in-app, sms, e-mail"],
      slug: Slugger.slugify(random_string(12)),
      rule_parameters: %{lower_limit: 10, upper_limit: 20},
      recepient_ids: [user1.id, user2.id],
      assignee_ids: [user3.id],
      policy_type: ["user"],
      severity: "warning",
      status: "un_resolved",
      app: "iot_manager",
      project: insert(:project),
      creator_id: user1.id
    }

    [alert_rule: alert_rule]
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  defp fetch_parameters(parameters) do
    Enum.reduce(parameters, [], fn param, acc ->
      acc ++ [Map.from_struct(param)]
    end)
  end
end
