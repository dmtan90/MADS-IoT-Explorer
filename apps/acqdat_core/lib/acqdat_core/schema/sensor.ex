defmodule AcqdatCore.Schema.Sensor do
  @moduledoc """
  Models a sensor in the system.

  To handle a sensor entity it is being assumed that a sensor
  can exist only with a device.
  A sensor could have been identified by combination of sensor type
  and device however, a device can have more than one sensor of the
  same type.
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Schema.{Device, Gateway}

  @typedoc """
  `uuid`: A universallly unique id for the sensor.
  `name`: A unique name for sensor per device. Note the same
          name can be used for sensor associated with another
          device.
  `device_id`: id of the device to which the sensor belongs.
               See `AcqdatCore.Schema.Device`
  """
  @type t :: %__MODULE__{}

  schema("acqdat_sensors") do
    field(:uuid, :string)
    field(:metadata, :map)
    field(:aesthetic_name, :string)
    field(:description, :string)
    field(:telemetry_attributes, {:array, :string})
    field(:image_url, :string)
    field(:slug, :string)
    field(:image, :any, virtual: true)
    # associations
    belongs_to(:gateway, Gateway, on_replace: :delete)
    timestamps(type: :utc_datetime)
  end

  @required_params ~w(gateway_id uuid aesthetic_name telemetry_attributes slug)a
  @optional_params ~w(metadata description image_url)a

  @permitted @required_params ++ @optional_params

  @update_required_params ~w(gateway_id)a
  @update_optional_params ~w(aesthetic_name telemetry_attributes metadata description image_url slug)a

  @update_permitted @update_required_params ++ @update_optional_params

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = sensor, params) do
    sensor
    |> cast(params, @permitted)
    |> add_uuid()
    |> add_slug()
    |> validate_required(@required_params)
    |> common_changeset()
  end

  def update_changeset(%__MODULE__{} = sensor, params) do
    sensor
    |> cast(params, @update_permitted)
    |> validate_required(@update_required_params)
    |> common_changeset()
  end

  def common_changeset(changeset) do
    changeset
    |> assoc_constraint(:gateway)
    |> unique_constraint(:slug)
  end

  defp add_uuid(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:uuid, UUID.uuid1(:hex))
  end

  defp add_slug(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:slug, Slugger.slugify(changeset.changes.aesthetic_name, ?@))
  end
end
