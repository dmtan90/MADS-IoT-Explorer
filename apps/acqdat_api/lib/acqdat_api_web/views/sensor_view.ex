defmodule AcqdatApiWeb.SensorView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.SensorView
  alias AcqdatApiWeb.DeviceView

  def render("sensor.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      name: sensor.name,
      uuid: sensor.uuid,
      device_id: sensor.device_id
    }
  end

  def render("sensor_with_preloads.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      name: sensor.name,
      uuid: sensor.uuid,
      device_id: sensor.device_id,
      device: render_one(sensor.device, DeviceView, "device.json")
    }
  end

  def render("sensors_details.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      name: sensor.name,
      uuid: sensor.uuid,
      device_id: sensor.device_id
    }
  end

  def render("index.json", sensor) do
    %{
      sensors: render_many(sensor.entries, SensorView, "sensor_with_preloads.json"),
      page_number: sensor.page_number,
      page_size: sensor.page_size,
      total_entries: sensor.total_entries,
      total_pages: sensor.total_pages
    }
  end

  def render("sensors_by_criteria_with_preloads.json", %{sensors_by_criteria: sensors_by_criteria}) do
    %{
      sensors: render_many(sensors_by_criteria, SensorView, "sensors_details.json")
    }
  end
end
