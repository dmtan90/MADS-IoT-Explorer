defmodule AcqdatCore.Alerts.Schema.AlertRules do
  use AcqdatCore.Schema

  schema "acqdat_alert_rules" do
    field :entity, :string, null: false
    add :entity_id, :integer, null: false
    field :policy_name, :string #need to be added in migration

    field :entity_parameters
    add :project_id, references("acqdat_projects", on_delete: :delete_all), null: false
    add :creator_id, references(:users), on_delete: :delete_all
    add :app, AppEnum.type()
    add :medium, {:array, MediumEnum.type()}
    add :policy_type, {:array, :string}
    add :recipient_ids, {:array, :integer}
    add :assignee_ids, {:array, :integer}
    add :severity, AlertSeverityEnum.type()
    add :status, AlertStatusEnum.type()
    add :description, :text

    embeds_many :rule_parameters, RuleParameters, on_replace: :delete do #policy parameters will be map
      field(:name, :string, null: false)
      field(:data_type, :string, null: false)
      # field(:entity_parameter_uuid, :string, null: false)
      # field(:entity_parameter_name, :string, null: false)
      field(:value, :string, null: false)
    end

    timestamps(type: :utc_datetime)
  end

end
