defmodule AcqdatCore.Widgets.Schema.Widget do
  @moduledoc """
  Models a Widget in the system.

  To handle a widget entity it is being assumed that a widget
  is a seperate entity and will be imported by user if payed.
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Widgets.Schema.WidgetType
  alias AcqdatCore.Widgets.Schema.Widget.VisualSettings
  alias AcqdatCore.Widgets.Schema.Widget.DataSettings

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
    field(:uuid, :string)
    field(:image_url, :string)
    field(:default_values, :map)
    field(:category, :string)
    field(:policies, :map)

    # embedded associations
    embeds_many(:visual_settings, VisualSettings)
    embeds_many(:data_settings, DataSettings)

    # associations
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


defmodule AcqdatCore.Widgets.Schema.Widget.VisualSettings do
  @moduledoc """
  Embed schema for visual settings in widget
  """
  use AcqdatCore.Schema
  alias AcqdatCore.Widgets.Schema.Widget.VisualSettings

  embedded_schema do
    field(:key, :string)
    field(:type, :string)
    field(:source, :map)
    field(:value, :string, default: "")
    field(:user_controlled, :boolean, default: false)
    embeds_one(:properties, VisualSettings)
  end
  @permitted ~w(key type source value user_controlled properties)a

  def chagngeset(%__MODULE__{} = settings, params) do
    cast(settings, params, @permitted)
  end

end

defmodule AcqdatCore.Widgets.Schema.Widget.DataSettings do
  @moduledoc """
  Embed schema for data related settings in widget.
  """
  use AcqdatCore.Schema

  embedded_schema do
    field(:axes, {:array, :map})
    field(:series, {:array, :map})
    field(:axes_values, {:array, :map})
    field(:series_values, {:array, :map})
  end

  @permitted ~w(axes series axes_values series_values)a

  def chagngeset(%__MODULE__{} = settings, params) do
    cast(settings, params, @permitted)
  end
end
