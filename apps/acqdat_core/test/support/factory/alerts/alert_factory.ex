defmodule AcqdatCore.Support.Alerts.Factory do
  defmacro __using__(_opts) do
    quote do
      alias AcqdatCore.Alerts.Schema.AlertRules

      @moduledoc """
        Alert factory, will consist support schemas to be used in alert functionality testing
      """
      def alert_rules_factory() do
        sensor = insert(:sensor)
        parameters = fetch_parameters(sensor.sensor_type.parameters)
        [user1, user2, user3] = insert_list(3, :user)

        %AlertRules{
          entity: "sensor",
          entity_id: sensor.id,
          policy_name: "Elixir.AcqdatCore.Alerts.Policies.RangeBased",
          entity_parameters: parameters,
          uuid: UUID.uuid1(:hex),
          communication_medium: ["in-app, sms, e-mail"],
          slug: sequence(:alert_rule_name, &"AlertRule#{&1}"),
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
      end

      defp fetch_parameters(parameters) do
        Enum.reduce(parameters, [], fn param, acc ->
          acc ++ [Map.from_struct(param)]
        end)
      end
    end
  end
end
