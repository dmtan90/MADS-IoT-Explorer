defmodule AcqdatCore.Alerts.Model.AlertRulesTest do
  @moduledoc """
    For testing alert rules model
  """
  use ExUnit.Case, async: true
  use AcqdatCore.DataCase
  alias AcqdatCore.Alerts.Model.AlertRules, as: ARModel
  import AcqdatCore.Support.Factory

  describe "create/1" do
    setup :setup_alert_rules

    test "with valid params", %{alert_rule: alert_rule} do
      assert {:ok, _alert_rule} = ARModel.create(alert_rule)
    end

    test "with invalid params" do
      assert {:error, _alert_rule} = ARModel.create(%{})
    end
  end

  describe "update/2" do
    setup :setup_alert_rules

    test "with valid params", %{alert_rule: alert_rule} do
      {:ok, alert_rule} = ARModel.create(alert_rule)
      assert {:ok, _alert_rule} = ARModel.update(alert_rule, %{policy_type: ["project"]})
    end

    test "with invalid params", %{alert_rule: alert_rule} do
      {:ok, alert_rule} = ARModel.create(alert_rule)
      assert {:error, _alert_rule} = ARModel.update(alert_rule, %{project_id: -1})
    end
  end

  describe "delete/1" do
    setup :setup_alert_rules

    test "with valid params", %{alert_rule: alert_rule} do
      {:ok, alert_rule} = ARModel.create(alert_rule)
      assert {:ok, _alert_rule} = ARModel.delete(alert_rule)
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
