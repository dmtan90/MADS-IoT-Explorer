defmodule AcqdatApiWeb.SensorView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.SensorView
  alias AcqdatApiWeb.GatewayView

  def render("sensor.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      aesthetic_name: sensor.aesthetic_name,
      uuid: sensor.uuid,
      slug: sensor.slug,
      metadata: sensor.metadata,
      description: sensor.description,
      image_url: sensor.image_url,
      telemetry_attributes: sensor.telemetry_attributes,
      gateway_id: sensor.gateway_id
    }
  end

  def render("sensor_with_preloads.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      aesthetic_name: sensor.aesthetic_name,
      uuid: sensor.uuid,
      slug: sensor.slug,
      metadata: sensor.metadata,
      description: sensor.description,
      image_url: sensor.image_url,
      telemetry_attributes: sensor.telemetry_attributes,
      gateway_id: sensor.gateway_id,
      gateway: render_one(sensor.gateway, GatewayView, "gateway.json")
    }
  end

  def render("sensors_details.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      aesthetic_name: sensor.aesthetic_name,
      uuid: sensor.uuid,
      slug: sensor.slug,
      metadata: sensor.metadata,
      description: sensor.description,
      image_url: sensor.image_url,
      telemetry_attributes: sensor.telemetry_attributes,
      gateway_id: sensor.gateway_id
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
