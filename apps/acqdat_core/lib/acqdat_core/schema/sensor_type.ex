defmodule AcqdatCore.Schema.SensorType do
  @moduledoc """
  Models a sensor-type in the system.

  A sensor-type is responsible for deciding the parameters of a IoT data sensor. Sensor will have the ID
  sensor-type deciding the parameters of that sensor
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Schema.{Organisation}

  @typedoc """
  `name`: A unique name for sensor per device. Note the same
          name can be used for sensor associated with another
          device.
   `description`: A description of the sensor-type
   `metadata`: A metadata field which will store all the data related to sensor-type
   `org_id`: A organisation to which the sensor and corresponding sensor-type is belonged to.
  `parameters`: The different parameters of the sensor.
  """
  @type t :: %__MODULE__{}

  schema("acqdat_sensor_types") do
    field(:uuid, :string, null: false)
    field(:slug, :string, null: false)
    field(:name, :string, null: false)
    field(:description, :string)
    field(:metadata, {:array, :map})

    embeds_many :parameters, Parameters, on_replace: :delete do
      field(:name, :string, null: false)
      field(:uuid, :string, null: false)
      field(:data_type, :string, null: false)
      field(:unit, :string)
    end

    # associations
    belongs_to(:org, Organisation, on_replace: :delete)

    timestamps(type: :utc_datetime)
  end

  @required_params ~w(uuid slug org_id name)a
  @optional_params ~w(description metadata)a
  @embedded_required_params ~w(name uuid data_type)a
  @embedded_optional_params ~w(unit)a
  @permitted_embedded @embedded_optional_params ++ @embedded_required_params

  @permitted @required_params ++ @optional_params

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = sensor_type, params) do
    sensor_type
    |> cast(params, @permitted)
    |> cast_embed(:parameters, with: &parameters_changeset/2)
    |> add_uuid()
    |> add_slug()
    |> validate_required(@required_params)
    |> common_changeset()
  end

  @spec update_changeset(
          AcqdatCore.Schema.SensorType.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def update_changeset(%__MODULE__{} = sensor_type, params) do
    sensor_type
    |> cast(params, @permitted)
    |> cast_embed(:parameters, with: &parameters_changeset/2)
    |> validate_required(@required_params)
    |> common_changeset()
  end

  @spec common_changeset(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def common_changeset(changeset) do
    changeset
    |> assoc_constraint(:org)
    |> unique_constraint(:slug, name: :acqdat_sensor_types_slug_index)
    |> unique_constraint(:uuid, name: :acqdat_sensor_types_uuid_index)
    |> unique_constraint(:name,
      name: :acqdat_sensor_types_name_org_id_index,
      message: "sensor type already exists"
    )
  end

  defp add_uuid(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:uuid, UUID.uuid1(:hex))
  end

  defp add_slug(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:slug, Slugger.slugify(random_string(12)))
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  defp parameters_changeset(schema, params) do
    schema
    |> cast(params, @permitted_embedded)
    |> add_uuid()
    |> validate_required(@embedded_required_params)
  end
end