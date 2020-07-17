defmodule AcqdatCore.Repo.Migrations.AcqdatAlertRules do
  use Ecto.Migration

  #alert rule are the set of rules that are being defined on for a particular entity parameter
  def change do
    create table(:acqdat_alert_rules) do
      add :entity, :string, null: false
      add :entity_id, :integer, null: false
      add :rule_parameters, {:array, :map}, null: false
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
    end

    create index(:acqdat_alert_rules, [:entity_id])
    create unique_index(:acqdat_alert_rules, [:entity_id, :project_id])
  end
end
