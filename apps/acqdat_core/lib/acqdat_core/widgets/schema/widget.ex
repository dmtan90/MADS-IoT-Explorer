defmodule AcqdatCore.Schema.Widget do
  @moduledoc """
  Models a Widget in the system.

  To handle a widget entity it is being assumed that a widget
  is a seperate entity and will be imported by user if payed.
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Schema.WidgetType

  @typedoc """
  `label`: widget name
  `uuid`: unique number
  `image_url`: image of widget
  `default value`: default intial values of widget
  `category`: category of the widget
  `policies`: policy of that widget
  `properties`: properties of the widget that includes other things also'
  `settings`: settings or current configuration of the widget
  """

  @type t :: %__MODULE__{}

  schema("acqdat_widgets") do
    field(:label, :string, null: false)
    field(:properties, :map)
    embeds_one(:settings, :map)
    field(:uuid, :string)
    field(:image_url, :string)
    field(:default_values, :map)
    field(:category, :string)
    field(:policies, :map)

    belongs_to(:widget_type, WidgetType)

    timestamps(type: :utc_datetime)
  end

  @required ~w(label settings default_values uuid widget_type_id)a
  @optional ~w(properties image_url policies category)a
  @params @required ++ @optional

  @spec changeset(
          __MODULE__.t(),
          map
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = widget, params) do
    widget
    |> cast(params, @params)
    |> add_uuid()
    |> validate_required(@required)
  end

  def update_changeset(%__MODULE__{} = widget, params) do
    widget
    |> cast(params, @params)
  end

  defp add_uuid(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:uuid, UUID.uuid1(:hex))
  end
end
