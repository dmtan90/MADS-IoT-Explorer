defmodule AcqdatApi.Sensor do
  alias AcqdatCore.Model.Sensor, as: SensorModel
  import AcqdatApiWeb.Helpers

  def create(params) do
    %{
      aesthetic_name: aesthetic_name,
      gateway_id: gateway_id,
      telemetry_attributes: telemetry_attributes,
      metadata: metadata,
      description: description,
      image_url: image_url
    } = params

    verify_sensor(
      SensorModel.create(%{
        aesthetic_name: aesthetic_name,
        gateway_id: gateway_id,
        telemetry_attributes: telemetry_attributes,
        metadata: metadata,
        description: description,
        image_url: image_url
      })
    )
  end

  defp verify_sensor({:ok, sensor}) do
    {:ok,
     %{
       id: sensor.id,
       aesthetic_name: sensor.aesthetic_name,
       gateway_id: sensor.gateway_id,
       telemetry_attributes: sensor.telemetry_attributes,
       metadata: sensor.metadata,
       description: sensor.description,
       image_url: sensor.image_url,
       slug: sensor.slug,
       uuid: sensor.uuid
     }}
  end

  defp verify_sensor({:error, sensor}) do
    {:error, %{error: extract_changeset_error(sensor)}}
  end

  def sensor_by_criteria(%{"gateway_id" => gateway_id} = _criteria) do
    {gateway_id, _} = Integer.parse(gateway_id)
    {:list, SensorModel.get_all_by_criteria(gateway_id)}
  end
end
