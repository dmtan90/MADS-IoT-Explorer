defmodule AcqdatApiWeb.Validators.Alerts.AlertRules do
  use Params

  defparams(
    verify_alert_rules(%{
      entity!: :string,
      entity_id!: :integer,
      policy_name!: :string,
      entity_parameters!: {:array, :map},
      uuid!: :string,
      communication_medium!: {:array, :string},
      slug!: :string,
      rule_parameters!: :map,
      recepient_ids!: {:array, :integer},
      assignee_ids!: {:array, :integer},
      policy_type!: {:array, :string},
      severity!: :string,
      status!: :string,
      app!: :string,
      project_id!: :integer,
      creator_id!: :integer,
      description: :string
    })
  )
end
