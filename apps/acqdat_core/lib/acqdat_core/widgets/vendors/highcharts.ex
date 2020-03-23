defmodule AcqdatCore.Widget.Vendors.HighCharts do
  @moduledoc """
    Embedded Schema of the settings of the widget with it keys and subkeys
  """

  use AcqdatCore.Schema
  # alias AcqdatCore.Schema.WidgetTypeSchema

  @master_params ~w(color_axis plot_options)a
  @chart_params ~w(vendor type background_color border_color plot_background_color height width)a
  @caption_params ~w(vendor text)a
  @credits_params ~w(vendor enabled)a
  @exporting_params ~w(vendor enabled)a
  @legend_params ~w(vendor enabled)a
  @navigation_params ~w(vendor button_options menu_item_style menu_style)a
  @pane_params ~w(vendor size class_name background_color)a
  @responsive_params ~w(vendor rules)a
  @subtitle_params ~w(vendor align style text)a
  @time_params ~w(vendor timezone useUTC)a
  @title_params ~w(vendor align style text)a
  @tool_tip_params ~w(vendor background_color datetime_labelformat text value_prefix value_suffix x_dateformat)a
  @x_axis_params ~w(vendor align_tricks alternate_grid_color datetime_labelformat labels title visible type opposite)a
  @z_axis_params ~w(vendor align_tricks alternate_grid_color datetime_labelformat labels title visible type opposite)a
  @y_axis_params ~w(vendor align_tricks alternate_grid_color datetime_labelformat labels title visible type opposite)a
  @series_params ~w(vendor data name)a

  embedded_schema do
    embeds_one :chart, Chart do
      field(:vendor, :string)
      field(:type, :string)
      field(:background_color, :string)
      field(:border_color, :string)
      field(:plot_background_color, :string)
      field(:height, :string)
      field(:width, :string)
    end

    embeds_one :caption, Caption do
      field(:vendor, :string)
      field(:text, :string)
    end

    field(:color_axis, :boolean, default: false)

    embeds_one :credits, Credits do
      field(:vendor, :string)
      field(:enabled, :boolean, default: false)
    end

    embeds_one :exporting, Exporting do
      field(:vendor, :string)
      field(:enabled, :boolean, default: false)
    end

    embeds_one :legend, Legend do
      field(:vendor, :string)
      field(:enabled, :boolean, default: false)
    end

    embeds_one :navigation, Navigation do
      field(:vendor, :string)
      field(:button_options, :string)
      field(:menu_item_style, :string)
      field(:menu_style, :string)
    end

    embeds_one :pane, Pane do
      field(:vendor, :string)
      field(:size, :string)
      field(:class_name, :string)
      field(:background_color, :string)
    end

    field(:plot_options, :boolean, default: false)

    embeds_one :responsive, Responsive do
      field(:vendor, :string)
      field(:rules, :string)
    end

    embeds_one :subtitle, Subtitle do
      field(:vendor, :string)
      field(:align, :string)
      field(:style, :string)
      field(:text, :string)
    end

    embeds_one :time, Timezone do
      field(:vendor, :string)
      field(:timezone, :string)
      field(:useUTC, :boolean, default: false)
    end

    embeds_one :title, Title do
      field(:vendor, :string)
      field(:align, :map)
      field(:style, :string)
      field(:text, :string)
    end

    embeds_one :tool_tip, ToolTip do
      field(:vendor, :string)
      field(:background_color, :string)
      field(:datetime_labelformat, :string)
      field(:text, :string)
      field(:value_prefix, :string)
      field(:value_suffix, :string)
      field(:x_dateformat, :string)
    end

    embeds_one :x_axis, Xaxis do
      field(:vendor, :string)
      field(:align_tricks, :string)
      field(:alternate_grid_color, :string)
      field(:datetime_labelformat, :string)
      field(:labels, :string)
      field(:title, :string)
      field(:visible, :string)
      field(:type, :string)
      field(:opposite, :string)
    end

    embeds_one :y_axis, Yaxis do
      field(:vendor, :string)
      field(:align_tricks, :string)
      field(:alternate_grid_color, :string)
      field(:datetime_labelformat, :string)
      field(:labels, :string)
      field(:title, :string)
      field(:visible, :string)
      field(:type, :string)
      field(:opposite, :string)
    end

    embeds_one :z_axis, Zaxis do
      field(:vendor, :string)
      field(:align_tricks, :string)
      field(:alternate_grid_color, :string)
      field(:datetime_labelformat, :string)
      field(:labels, :string)
      field(:title, :string)
      field(:visible, :string)
      field(:type, :string)
      field(:opposite, :string)
    end

    embeds_one :series, Series do
      field(:vendor, :string)
      field(:data, :string)
      field(:name, :string)
    end
  end

  def changeset(%__MODULE__{} = data, params) do
    data
    |> cast(params, @master_params)
    |> put_change(
      :chart,
      chart_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Chart{}, params["chart"])
    )
    |> put_change(
      :caption,
      caption_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Caption{}, params["caption"])
    )
    |> put_change(
      :credits,
      credits_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Credits{}, params["credits"])
    )
    |> put_change(
      :exporting,
      exporting_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Exporting{}, params["exporting"])
    )
    |> put_change(
      :legend,
      legend_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Legend{}, params["legend"])
    )
    |> put_change(
      :navigation,
      navigation_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Navigation{}, params["navigation"])
    )
    |> put_change(
      :pane,
      pane_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Pane{}, params["pane"])
    )
    |> put_change(
      :responsive,
      responsive_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Responsive{}, params["responsive"])
    )
    |> put_change(
      :subtitle,
      subtitle_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Subtitle{}, params["subtitle"])
    )
    |> put_change(
      :time,
      time_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Timezone{}, params["time"])
    )
    |> put_change(
      :title,
      title_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Title{}, params["title"])
    )
    |> put_change(
      :tool_tip,
      tool_tip_changeset(%AcqdatCore.Schema.WidgetTypeSchema.ToolTip{}, params["tool_tip"])
    )
    |> put_change(
      :z_axis,
      z_axis_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Zaxis{}, params["z_axis"])
    )
    |> put_change(
      :x_axis,
      x_axis_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Xaxis{}, params["x_axis"])
    )
    |> put_change(
      :y_axis,
      y_axis_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Yaxis{}, params["y_axis"])
    )
    |> put_change(
      :series,
      series_changeset(%AcqdatCore.Schema.WidgetTypeSchema.Series{}, params["series"])
    )
  end

  def chart_changeset(data, params) do
    data
    |> cast(params, @chart_params)
    |> validate_required(@chart_params)
  end

  def caption_changeset(data, params) do
    data
    |> cast(params, @caption_params)
    |> validate_required(@caption_params)
  end

  def credits_changeset(data, params) do
    data
    |> cast(params, @credits_params)
    |> validate_required(@credits_params)
  end

  def exporting_changeset(data, params) do
    data
    |> cast(params, @exporting_params)
    |> validate_required(@exporting_params)
  end

  def legend_changeset(data, params) do
    data
    |> cast(params, @legend_params)
    |> validate_required(@legend_params)
  end

  def navigation_changeset(data, params) do
    data
    |> cast(params, @navigation_params)
    |> validate_required(@navigation_params)
  end

  def pane_changeset(data, params) do
    data
    |> cast(params, @pane_params)
    |> validate_required(@pane_params)
  end

  def responsive_changeset(data, params) do
    data
    |> cast(params, @responsive_params)
    |> validate_required(@responsive_params)
  end

  def subtitle_changeset(data, params) do
    data
    |> cast(params, @subtitle_params)
    |> validate_required(@subtitle_params)
  end

  def time_changeset(data, params) do
    data
    |> cast(params, @time_params)
    |> validate_required(@time_params)
  end

  def title_changeset(data, params) do
    data
    |> cast(params, @title_params)
    |> validate_required(@title_params)
  end

  def tool_tip_changeset(data, params) do
    data
    |> cast(params, @tool_tip_params)
    |> validate_required(@tool_tip_params)
  end

  def x_axis_changeset(data, params) do
    data
    |> cast(params, @x_axis_params)
    |> validate_required(@x_axis_params)
  end

  def z_axis_changeset(data, params) do
    data
    |> cast(params, @z_axis_params)
    |> validate_required(@z_axis_params)
  end

  def y_axis_changeset(data, params) do
    data
    |> cast(params, @y_axis_params)
    |> validate_required(@y_axis_params)
  end

  def series_changeset(data, params) do
    data
    |> cast(params, @series_params)
    |> validate_required(@series_params)
  end
end
