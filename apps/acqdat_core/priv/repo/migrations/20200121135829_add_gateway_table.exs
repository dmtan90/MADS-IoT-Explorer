defmodule AcqdatCore.Repo.Migrations.AddGatewayTable do
  use Ecto.Migration

  def change do
    create table("acqdat_gateways") do
      add(:name, :string, null: false)
      add(:site_id, references("acqdat_sites", on_delete: :delete_all), null: true)
      add(:configuration, :map)
      add(:last_config_update, :map)
      add(:image_url, :string)

      timestamps(type: :timestamptz)
    end  
  end
end
