defmodule AcqdatCore.Schema.DigitalTwin do
  @moduledoc """
  Models a Digital Twin in the process.

  A Digital Twin will belongs to a particular site and process.
  """

  use AcqdatCore.Schema

  alias AcqdatCore.Schema.Site
  alias AcqdatCore.Schema.Process

  @typedoc """
  `name`: Name for easy identification of the digital twin.
  """
  @type t :: %__MODULE__{}

  schema("acqdat_digital_twins") do
    field(:name, :string)
    belongs_to(:process, Process)
    belongs_to(:site, Site)
    timestamps(type: :utc_datetime)
  end

  @required_params ~w(name site_id process_id)a

  @permitted @required_params
  @update_required_params ~w(name)a

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = digital_twin, params) do
    digital_twin
    |> cast(params, @permitted)
    |> validate_required(@required_params)
  end

  def update_changeset(%__MODULE__{} = digital_twin, params) do
    digital_twin
    |> cast(params, @permitted)
    |> validate_required(@update_required_params)
  end
end