defmodule AcqdatCore.Repo.Migrations.AddDigitalTwinTable do
  use Ecto.Migration

  def change do
    create table("acqdat_digital_twins") do
      add(:name, :string, null: false)
      add(:site_id, references("acqdat_sites", on_delete: :delete_all), null: false)
      add(:process_id, references("acqdat_processes", on_delete: :delete_all), null: false)
      timestamps(type: :timestamptz)
    end
  end
end
