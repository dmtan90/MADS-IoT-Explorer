defmodule AcqdatApiWeb.AssetView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.AssetView
  alias AcqdatApiWeb.SensorView

  def render("asset_tree.json", %{asset: asset}) do
    params =
      with true <- Map.has_key?(asset, :assets) do
        render_many(asset.assets, AssetView, "asset_tree.json")
      else
        false ->
          render_many(asset.sensors, SensorView, "sensor_tree.json")
      end

    %{
      type: "Asset",
      # description: asset.description,
      id: asset.id,
      # image_url: asset.image_url,
      # inserted_at: asset.inserted_at,
      # mapped_parameters: asset.mapped_parameters,
      # metadata: asset.metadata,
      name: asset.name,
      # slug: asset.slug,
      # updated_at: asset.updated_at,
      # uuid: asset.uuid,
      entities: params
    }
  end
end
