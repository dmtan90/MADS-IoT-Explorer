defmodule AcqdatCore.Seed.Sensor do

  alias AcqdatCore.Schema.{Organisation, Asset, Sensor}
  alias AcqdatCore.Repo

  @energy_parameters_list [
    %{name: "Voltage", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "Current", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "Power", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "Energy", uuid: UUID.uuid1(:hex), type: "string"}
  ]

  @vibration_parameters_list [
    %{name: "x_axis vel", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "z_axis vel", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "x_axis acc", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "z_axis acc", uuid: UUID.uuid1(:hex), type: "string"}
  ]

  @temperature_parameters_list [
    %{name: "Temperature", uuid: UUID.uuid1(:hex), type: "string"}
  ]

  @occupancy_sensor [
    %{name: "Occupancy", uuid: UUID.uuid1(:hex), type: "boolean"}
  ]

  @air_quality_sensor [
    %{name: "Air Temperature", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "O2 Level", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "CO2 Level", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "CO Level", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "NH3 Level", uuid: UUID.uuid1(:hex), type: "string"}
  ]

  @soil_moisture_sensor [
    %{name: "Soil Humidity", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "N Level", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "P Level", uuid: UUID.uuid1(:hex), type: "string"},
    %{name: "K Level", uuid: UUID.uuid1(:hex), type: "string"}
  ]


  
  def seed_sensors() do
    [org] = Repo.all(Organisation)
    assets = Repo.all(Asset)
    sensors = assets
    |> Enum.map(fn
      %Asset{name: "Wet Process"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Energy Meter", parameters: @energy_parameters_list, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Energy Meter")}
      %Asset{name: "Dry Process"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Temperature Sensor", parameters: @temperature_parameters_list, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Temperature Sensor")}
      %Asset{name: "Ipoh Factory"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Air Quality Sensor", parameters: @air_quality_sensor, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Air Quality Sensor")}
      %Asset{name: "Common Space"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Occupancy Sensor", parameters: @air_quality_sensor, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Occupancy Sensor")}
      %Asset{name: "Executive Space"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Occupancy Sensor", parameters: @air_quality_sensor, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Occupancy Sensor")}
      %Asset{name: "Singapore Office"} = asset ->  
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Energy Meter", parameters: @energy_parameters_list, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Energy Meter")}
      %Asset{name: "Bintan Factory"} = asset ->  %{}

      end)
    |> Enum.map(fn sensor ->
      sensor
      |> Map.put(:inserted_at, DateTime.truncate(DateTime.utc_now(), :second))
      |> Map.put(:updated_at, DateTime.truncate(DateTime.utc_now(), :second))
    end)

    sensors1 = 
    assets
    |> Enum.map(fn
      %Asset{name: "Wet Process"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Vibration Sensor", parameters: @vibration_parameters_list, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Vibration Sensot")}
      %Asset{name: "Dry Process"} = asset -> %{}
      %Asset{name: "Ipoh Factory"} = asset ->
        %{org_id: org.id, parent_id: asset.id, uuid: UUID.uuid1(:hex), name: "Soil Moisture Sensor", parameters: @soil_moisture_sensor, parent_type: "Asset", slug: Slugger.slugify(asset.slug <> "Soil Moisture Sensor")}
      %Asset{name: "Common Space"} = asset -> %{}
      %Asset{name: "Executive Space"} = asset -> %{}
      %Asset{name: "Singapore Office"} = asset -> %{}
      %Asset{name: "Bintan Factory"} = asset ->  %{}

      end)
    |> Enum.map(fn sensor ->
      sensor
      |> Map.put(:inserted_at, DateTime.truncate(DateTime.utc_now(), :second))
      |> Map.put(:updated_at, DateTime.truncate(DateTime.utc_now(), :second))
    end)

    params = 
    %{}
    |> Map.put(:inserted_at, DateTime.truncate(DateTime.utc_now(), :second))
    |> Map.put(:updated_at, DateTime.truncate(DateTime.utc_now(), :second))

    sensors = sensors ++ sensors1
    sensors = sensors -- [params, params, params, params, params, params]

    Enum.each(sensors, fn sensor -> 
      changeset = Sensor.changeset(%Sensor{}, sensor)
      Repo.insert(changeset)
    end)
    
  end
end
