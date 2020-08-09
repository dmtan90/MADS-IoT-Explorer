defmodule AcqdatApi.Alerts.AlertRules do
  @moduledoc """
  All the helper functions related to alert rules are either written here or being accessed from here
  """
  alias AcqdatCore.Alerts.Model.AlertRules
  import AcqdatApiWeb.Helpers
  alias AcqdatCore.Model.RoleManagement.User

  defdelegate update(alert_rules, params), to: AlertRules
  defdelegate get_all(data), to: AlertRules
  defdelegate delete(alert_rules), to: AlertRules

  def create(params) do
    params = params_extraction(params)
    verify_alert_rules(AlertRules.create(params))
  end

  def verify_alert_rules({:ok, alert_rules}) do
    recepient_ids = send_alert(alert_rules)
    alert_rules = Map.replace!(alert_rules, :recepient_ids, recepient_ids)
    {:ok, alert_rules}
  end

  def verify_alert_rules({:error, message}) do
    {:error, %{error: extract_changeset_error(message)}}
  end

  defp params_extraction(params) do
    Map.from_struct(params)
    |> Map.drop([:_id, :__meta__])
  end

  defp send_alert(alert) do
    Enum.reduce(alert.recepient_ids, fn recipient, acc ->
      if recipient != 0 do
        user = User.extract_email(recipient)
        acc ++ [user.email]
      end
    end)
  end
end
