defmodule AcqdatCore.Schema.WidgetType do
  @moduledoc """
    Track down the different widgets that we have used from different vendors and whats the settings of each widget that we are storing 
    Schema
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Schema.WidgetTypeSchema

  alias AcqdatCore.Schema.Widget

  @typedoc """
  'vendor': name of the vendor
  'schema': widget schema
  'vendor metadata': it's metadata
  """

  @type t :: %__MODULE__{}

  schema("acqdat_widget_type") do
    field(:vendor, :string, null: false)
    embeds_one(:schema, WidgetTypeSchema)
    field(:vendor_metadata, :map)

    has_many(:widget, Widget)
    timestamps(type: :utc_datetime)
  end

  @required ~w(vendor)a
  @optional ~w(vendor_metadata)a
  @params ~w(vendor vendor_metadata)a

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = widget_type, params) do
    widget_type
    |> cast(params, @params)
    |> validate_required(@required)
    |> cast_embed(:schema, with: &WidgetTypeSchema.changeset/2)
  end

  def update_changeset(%__MODULE__{} = widget_type, params) do
    widget_type
    |> cast(params, @params)
    |> put_change(:schema, with: &WidgetTypeSchema.changeset/2)
  end
end
