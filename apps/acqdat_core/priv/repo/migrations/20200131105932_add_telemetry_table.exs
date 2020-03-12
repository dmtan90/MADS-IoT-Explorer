defmodule AcqdatCore.Repo.Migrations.AddTelemetryTable do
  use Ecto.Migration

  def change do
    create table("acqdat_telemetry_data") do
      add(:datapoint, :map)
      timestamps(type: :timestamptz)
    end
  end
end
