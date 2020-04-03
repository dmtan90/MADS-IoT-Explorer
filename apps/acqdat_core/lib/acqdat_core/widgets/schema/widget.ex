defmodule AcqdatCore.Widgets.Schema.Widget do
  @moduledoc """
  Widgets are used for creating visualizations from data sources.

  A widget has two important properties along with others:
  - `data_settings`
  - `visual_settings`

  **Data Settings**
  The data settings holds properties of data source which would be
  shown by an instance of the specific widget.
  A data source would be put on different axes for a widget. A data source
  is a columnar for an axes.

  **Visual Settings**
  Visual Settings hold the keys that can be set for the particular widget.
  The keys are defined by module for a particular vendor the information
  is derived from widget_type to which the widget belongs.
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Widgets.Schema.WidgetType
  alias AcqdatCore.Widgets.Schema.Widget.Settings
  alias AcqdatCore.Widgets.Schema.Widget.DataSettings

  @typedoc """
  `label`: widget name
  `uuid`: unique number
  `image_url`: holds the image url for a widget
  `default_values`: holds initial values for keys defined in data and visual
    settings
  `category`: category of the widget
  `policies`: policy of that widget
  `properties`: properties of a widget
  `visual_settings`: holds visualization related settings
  `data_settings`: holds data related settings for a widget
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
    embeds_many(:visual_settings, Settings)
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

defmodule AcqdatCore.Widgets.Schema.Widget.Settings do
  @moduledoc """
  Embed schema for visual settings in widget

  ## Note
  - User controlled field holds whether user will fill in the values for the
  given key.
  - A field which is not controlled by the user should have it's value set in
  the value field. For user controlled fields it would be empty.
  """
  use AcqdatCore.Schema
  alias AcqdatCore.Widgets.Schema.Widget.Settings

  embedded_schema do
    field(:key, :string)
    field(:type, :string)
    field(:source, :map)
    field(:value, :map)
    field(:user_controlled, :boolean, default: false)
    embeds_one(:properties, Settings)
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
  alias AcqdatCore.Widgets.Schema.Widget.Settings

  embedded_schema do
    embeds_many(:axes) do
      field(:name, :string)
      field(:multiple, :boolean, default: false)
    end
    embeds_many(:series, Settings)
  end

  @permitted ~w(axes series axes_values series_values)a

  def changeset(%__MODULE__{} = settings, params) do
    cast(settings, params, @permitted)
  end
end
