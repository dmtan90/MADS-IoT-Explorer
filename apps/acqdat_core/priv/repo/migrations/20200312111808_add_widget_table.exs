defmodule AcqdatCore.Repo.Migrations.AddWidgetTable do
  use Ecto.Migration

  def change do
    create table("acqdat_widgets") do
      add(:label, :string)
      add(:policies, :map)
      add(:default_values, :map)
      add(:uuid, :string, null: false)
      add(:properties, :map)
      add(:visual_settings, :map)
      add(:data_settings, :map)
      add(:category, :string)
      add(:image_url, :string)

      timestamps(type: :timestamptz)
    end
  end
end
