defmodule AcqdatCore.Repo.Migrations.DeleteSensorType do
  use Ecto.Migration

  def up do
    drop constraint("acqdat_sensors", "acqdat_sensors_sensor_type_id_fkey")
    drop_if_exists table("acqdat_sensor_types")
    alter table("acqdat_sensors") do
      remove(:sensor_type_id)
    end
  end

  def down do
    create table("acqdat_sensor_types") do
      add(:name, :string, null: false)
      add(:make, :text)
      add(:visualizer, :string)
      add(:identifier, :string, null: false)
      add(:value_keys, {:array, :string}, null: false)

      timestamps(type: :timestamptz)
    end

    create unique_index("acqdat_sensor_types", [:name])
    create unique_index("acqdat_sensor_types", [:identifier])

    alter table("acqdat_sensors") do
      add(:sensor_type_id, references("acqdat_sensor_types", on_delete: :delete_all), null: false)
    end
  end
end
