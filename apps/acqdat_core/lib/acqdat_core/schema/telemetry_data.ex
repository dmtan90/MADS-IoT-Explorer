defmodule AcqdatCore.Schema.TelemetryData do
  @moduledoc """
  Models a telemetry daya in the system.

  To handle a telemetry entity it is being assumed that a equiment
  can exist only with a gateway.
  """
  use AcqdatCore.Schema

  @type t :: %__MODULE__{}

  schema("acqdat_telemetry_data") do
    field(:datapoint, :map)
    timestamps(type: :utc_datetime)
  end

  @permitted ~w(datapoint)a

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = telemetry_data, params) do
    telemetry_data
    |> cast(params, @permitted)
    |> validate_required(@permitted)
  end

  def update_changeset(%__MODULE__{} = telemetry_data, params) do
    telemetry_data
    |> cast(params, @permitted)
    |> validate_required(@permitted)
  end
end
