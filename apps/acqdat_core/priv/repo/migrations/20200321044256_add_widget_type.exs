defmodule AcqdatCore.Repo.Migrations.AddWidgetType do
  use Ecto.Migration

  def change do
    create table("acqdat_widget_type") do
      add(:name, :string, null: false)
      add(:vendor, WidgetVendorEnum.type(), null: false)
      add(:module, WidgetVendorSchemaEnum.type(), null: false)
      add(:vendor_metadata, :map)
      
      timestamps(type: :timestamptz)
    end
  end
end
