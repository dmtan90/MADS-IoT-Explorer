defmodule AcqdatCore.Model.Asset do
  import Ecto.Query
  import AsNestedSet.Queriable, only: [dump_one: 2]
  alias AcqdatCore.Model.Sensor, as: SensorModel
  alias AcqdatCore.Schema.Asset
  alias AcqdatCore.Repo

  def child_assets(org_id) do
    query =
      from(asset in Asset,
        where: asset.org_id == ^org_id and is_nil(asset.parent_id) == true
      )

    org_assets = Repo.all(query)

    org_assets =
      Enum.reduce(org_assets, [], fn asset, acc ->
        entities =
          AsNestedSet.descendants(asset)
          |> AsNestedSet.execute(Repo)

        case List.first(entities) do
          nil ->
            sensors = SensorModel.child_sensors(asset)
            asset = Map.put_new(asset, :sensors, sensors)
            acc = acc ++ [asset]

          _ ->
            entities_with_sensors =
              Enum.reduce(entities, [], fn asset, acc_sensor ->
                entities = SensorModel.child_sensors(asset)
                asset = Map.put_new(asset, :sensors, entities)
                acc_sensor = acc_sensor ++ [asset]
              end)

            asset = Map.put_new(asset, :assets, entities_with_sensors)
            acc = acc ++ [asset]
        end
      end)
  end
end
