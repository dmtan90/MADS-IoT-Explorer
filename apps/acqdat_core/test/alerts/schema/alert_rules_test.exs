defmodule AcqdatCore.Alerts.Schema.AlertRulesTest do
  @moduledoc """
  Testing module for alert rules schema
  """
  use ExUnit.Case, async: true
  use AcqdatCore.DataCase
  alias AcqdatCore.Alerts.Schema.AlertRules
  import AcqdatCore.Support.Factory

  describe "changeset/2" do
    setup :setup_alert_rules

    test "returns a valid changeset", %{alert_rule: alert_rule} do
      %{valid?: validity} = AlertRules.changeset(%AlertRules{}, alert_rule)
      assert validity
    end

    test "returns invalid changeset for missing required params" do
      %{valid?: validity} = changeset = AlertRules.changeset(%AlertRules{}, %{})
      refute validity

      assert %{
               entity: ["can't be blank"],
               entity_id: ["can't be blank"],
               policy_name: ["can't be blank"],
               entity_parameters: ["can't be blank"],
               rule_parameters: ["can't be blank"],
               policy_type: ["can't be blank"],
               project_id: ["can't be blank"],
               creator_id: ["can't be blank"]
             } = errors_on(changeset)
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
