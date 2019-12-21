defmodule AcqdatCore.Repo.Migrations.AddProcessTable do
  use Ecto.Migration

  def change do
    create table("acqdat_processes") do
      add(:name, :string, null: false)
      add(:site_id, references("acqdat_sites", on_delete: :delete_all), null: false)
      timestamps(type: :timestamptz)
    end
  end
end
