defmodule AcqdatCore.Repo.Migrations.AddWidgetType do
  use Ecto.Migration

  def change do
    create table("acqdat_widget_type") do
      add(:vendor, :string, null: false)
      add(:schema, :map)
      add(:vendor_metadata, :map)
      
      timestamps(type: :timestamptz)
    end
  end
end
