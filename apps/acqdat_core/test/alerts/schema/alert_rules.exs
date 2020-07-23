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
    gateway = insert(:gateway)

    alert_rule = %{
      entity: "Gateway",
      entity_id: gateway.id,
      policy_name: "RangeBasedPolicy",
      entity_parameters: %{
        parameter_name: "temp",
        parameter_uuid: UUID.uuid1(:hex)
      },
      uuid: UUID.uuid1(:hex),
      slug: Slugger.slugify(random_string(12)),
      rule_parameters: %{
        "lower_limit" => 10,
        "upper_limit" => 20
      },
      policy_type: ["user"],
      description: "This is range based alert rule",
      project_id: gateway.project_id,
      creator_id: gateway.project.creator_id
    }

    [alert_rule: alert_rule]
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
