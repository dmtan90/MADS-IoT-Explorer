defmodule AcqdatCore.Schema.Gateway do
  @moduledoc """
    Models a gateway in the system.

    A gateway can be any entity which contains configuration and belong to a site and has many sensors.
  """

  use AcqdatCore.Schema

  alias AcqdatCore.Schema.Site
  alias AcqdatCore.Schema.Sensor

  @typedoc """
  `name`: Name for easy identification of the gateway.
  `configuration`: configuration of the gateway
  `last update configuration`: previous configurations with their respective dates
  """
  @type t :: %__MODULE__{}

  schema("acqdat_gateways") do
    field(:name, :string)
    field(:configuration, :map)
    field(:last_config_update, :map)
    field(:image_url, :string)
    field(:image, :any, virtual: true)
    belongs_to(:site, Site, on_replace: :delete)
    has_many(:sensor, Sensor)
    timestamps(type: :utc_datetime)
  end

  @required ~w(name configuration site_id)a
  @optional ~w(last_config_update image_url)a

  @permitted @required ++ @optional

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()

  def changeset(%__MODULE__{} = gateway, params) do
    gateway
    |> cast(params, @permitted)
    |> validate_required(@required)
    |> common_changeset()
  end

  def update_changeset(%__MODULE__{} = gateway, params) do
    gateway
    |> cast(params, @permitted)
    |> validate_required(@required)
    |> check_and_store_configuration(gateway)
    |> common_changeset()
  end

  def common_changeset(changeset) do
    changeset
    |> assoc_constraint(:site)
  end

  defp check_and_store_configuration(changeset, previous_gateway) do
    current_date_and_time = DateTime.utc_now()

    with true <- Map.has_key?(changeset.changes, :configuration) do
      case is_nil(previous_gateway.last_config_update) do
        true ->
          last_config_update = %{"#{current_date_and_time}" => previous_gateway.configuration}
          changes = Map.put_new(changeset.changes, :last_config_update, last_config_update)
          Map.replace!(changeset, :changes, changes)

        false ->
          last_config_update = previous_gateway.last_config_update

          last_config_update =
            Map.put_new(
              last_config_update,
              "#{current_date_and_time}",
              previous_gateway.configuration
            )

          changes = Map.put_new(changeset.changes, :last_config_update, last_config_update)
          Map.replace!(changeset, :changes, changes)
      end
    else
      false ->
        changeset
    end
  end
end
