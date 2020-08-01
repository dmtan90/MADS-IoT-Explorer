defmodule AcqdatApiWeb.Alerts.AlertRulesView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.Alerts.AlertRulesView

  def render("alert_rules.json", %{alert_rules: alert_rules}) do
    %{
      app: alert_rules.app,
      assignee_ids: alert_rules.assignee_ids,
      communication_medium: alert_rules.communication_medium,
      creator_id: alert_rules.creator_id,
      description: alert_rules.description,
      entity: alert_rules.entity,
      entity_id: alert_rules.entity_id,
      entity_parameters:
        render_many(alert_rules.entity_parameters, AlertRulesView, "parameter.json"),
      id: alert_rules.id,
      policy_name: alert_rules.policy_name,
      policy_type: alert_rules.policy_type,
      project_id: alert_rules.project_id,
      recepient_ids: alert_rules.recepient_ids,
      rule_parameters: alert_rules.rule_parameters,
      severity: alert_rules.severity,
      slug: alert_rules.slug,
      status: alert_rules.status,
      uuid: alert_rules.uuid
    }
  end

  def render("parameter.json", %{alert_rules: params}) do
    %{
      data_type: params.data_type,
      uuid: params.data_type,
      unit: params.data_type,
      name: params.data_type
    }
  end
end
