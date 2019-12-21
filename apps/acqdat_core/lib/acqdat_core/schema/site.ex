defmodule AcqdatCore.Schema.Site do
  @moduledoc """
  Models a site in the system.

  A site can be any entity which contains multiple devices and has many processes.
  """

  use AcqdatCore.Schema

  alias AcqdatCore.Schema.Device
  alias AcqdatCore.Schema.Process

  @typedoc """
  `name`: Name for easy identification of the site.
  """
  @type t :: %__MODULE__{}

  schema("acqdat_sites") do
    field(:name, :string)
    has_many(:devices, Device)
    has_many(:processes, Process)
    timestamps(type: :utc_datetime)
  end

  @required_params ~w(name)a

  @permitted @required_params
  @update_required_params ~w(name)a

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = site, params) do
    site
    |> cast(params, @permitted)
    |> validate_required(@required_params)
    |> common_changeset()
  end

  def update_changeset(%__MODULE__{} = site, params) do
    site
    |> cast(params, @permitted)
    |> validate_required(@update_required_params)
    |> common_changeset()
  end

  def common_changeset(changeset) do
    changeset
    |> unique_constraint(:name, name: :acqdat_sites_name_index)
  end
end
