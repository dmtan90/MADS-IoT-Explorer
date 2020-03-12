defmodule AcqdatCore.Repo.Migrations.AlterSensorTable do
  use Ecto.Migration

  def up do
    drop constraint("acqdat_sensors", "acqdat_sensors_device_id_fkey") 

    alter table("acqdat_sensors") do
      remove(:name)
      remove(:device_id)
      add(:metadata, :map)
      add(:aesthetic_name, :string, null: false)
      add(:description, :text)
      add(:telemetry_attributes, {:array, :string})
      add(:image_url, :string)
      add(:slug, :string)
      add(:gateway_id, references("acqdat_gateways", on_delete: :delete_all), null: false)
    end

    create unique_index("acqdat_sensors", [:slug])
  end

  def down do
    drop constraint("acqdat_sensors", "acqdat_sensors_gateway_id_fkey")
    alter table("acqdat_sensors") do
      remove(:metadata)
      remove(:aesthetic_name)
      remove(:description)
      remove(:telemetry_attributes)
      remove(:gateway_id)
      remove(:image_url)
      remove(:slug)
      add(:name, :string, null: false)
      add(:device_id, references("acqdat_devices", on_delete: :delete_all), null: false)
    end
  end
end
