defmodule AcqdatCore.Repo.Migrations.AcqdatAlertRules do
  use Ecto.Migration

  #alert rule are the set of rules that are being defined on for a particular entity parameter
  def change do
    create table(:acqdat_alert_rules) do
      add :entity, :string, null: false
      add :entity_id, :integer, null: false
      add :uuid, :string, null: false
      add :slug, :string, null: false
      add :app, AppEnum.type(), null: false
      add :policy_name, PolicyDefinitionModuleEnum.type(), null: false
      add :rule_parameters, :map, null: false
      add :entity_parameters, {:array, :map}, null: false
      add :communication_medium, {:array, :string}
      add :recepient_ids, {:array, :integer}
      add :assignee_ids, {:array, :integer}
      add :severity, AlertSeverityEnum.type(), null: false
      add :status, AlertStatusEnum.type(), null: false
      add :project_id, references("acqdat_projects", on_delete: :delete_all), null: false
      add :creator_id, references(:users), on_delete: :delete_all
      add :policy_type, {:array, :string}
      add :description, :text

      timestamps(type: :timestamptz)
    end

    create index(:acqdat_alert_rules, [:entity_id])
    create unique_index(:acqdat_alert_rules, [:uuid])
    create unique_index(:acqdat_alert_rules, [:slug])
  end
end
