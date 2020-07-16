defmodule AcqdatCore.Repo.Migrations.AcqdatAlertPolicy do
  use Ecto.Migration

  def change do
    create table(:acqdat_alert_policy) do
      add :rules, {:array, :map}
    end
  end
end
