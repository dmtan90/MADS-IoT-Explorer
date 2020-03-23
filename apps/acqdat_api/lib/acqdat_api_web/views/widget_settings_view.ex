defmodule AcqdatApiWeb.WidgetSettingsView do
  use AcqdatApiWeb, :view

  def render("schema.json", %{widget_settings: schema}) do
    %{
      id: schema.id,
      # caption: %{id: schema.caption.id, text: schema.caption.text, vendor: schema.caption.vendor},
      caption: Map.from_struct(schema.caption),
      # %{id: schema.chart.id, background_color: schema.chart.background_color, border_color: schema.chart.border_color, height: schema.chart.height, plot_background_color: schema.chart.plot_background_color, type: schema.chart.type, vendor: schema.chart.vendor, width: schema.chart.width},
      chart: Map.from_struct(schema.chart),
      color_axis: schema.color_axis,
      # %{enabled: schema.credits.enabled, id: schema.credits.id, vendor: schema.credits.vendor},
      credits: Map.from_struct(schema.credits),
      # %{enabled: schema.exporting.enabled, id: schema.exporting.id, vendor: schema.exporting.vendor},
      exporting: Map.from_struct(schema.exporting),
      # %{enabled: schema.legend.enabled, id: schema.legend.id, vendor: schema.legend.vendor},
      legend: Map.from_struct(schema.legend),
      navigation: Map.from_struct(schema.navigation),
      pane: Map.from_struct(schema.pane),
      plot_options: schema.plot_options,
      # %{id: schema.resp},
      responsive: Map.from_struct(schema.responsive),
      # %{data: schema.series.data, id: schema.series.id, name: schema.series.name, vendor: schema.series.vendor},
      series: Map.from_struct(schema.series),
      # %{align: schema.subtitle.align, id: schema.subtitle.id, style: schema.subtitle.style, text: schema.subtitle.text, vendor: schema.subtitle.vendor},
      subtitle: Map.from_struct(schema.subtitle),
      # %{id: schema.time.id, timezone: schema.time.timezone, useUTC: schema.time.useUTC, vendor: schema.time.vendor},
      time: Map.from_struct(schema.time),
      # %{align: schema.title.align, id: schema.title.id, style: schema.title.style, text: schema.title.text, vendor: schema.title.vendor},
      title: Map.from_struct(schema.title),
      # %{background_color: schema.tool_tip.background_color, datetime_labelformat: schema.tool_tip.datetime_labelformat, id: schema.tool_tip.id, text: schema.tool_tip.text, value_prefix: schema.tool_tip.value_prefix, value_suffix: schema.tool_tip.value_suffix, vendor: schema.tool_tip.vendor, x_dateformat: schema.tool_tip.x_dateformat},
      tool_tip: Map.from_struct(schema.tool_tip),
      # %{align_tricks: schema.x_axis.align_tricks, alternate_grid_color: schema.x_axis.alternate_grid_color, datetime_labelformat: schema.x_axis.datetime_labelformat, id: schema.x_axis.id, labels: schema.x_axis.labels, opposite: schema.x_axis.opposite, title: schema.x_axis.title, type: schema.x_axis.type, vendor: schema.x_axis.vendor, visible: schema.x_axis.visible},
      x_axis: Map.from_struct(schema.x_axis),
      # %{align_tricks: schema.y_axis.align_tricks, alternate_grid_color: schema.y_axis.alternate_grid_color, datetime_labelformat: schema.y_axis.datetime_labelformat, id: schema.y_axis.id, labels: schema.y_axis.labels, opposite: schema.y_axis.opposite, title: schema.y_axis.title, type: schema.y_axis.type, vendor: schema.y_axis.vendor, visible: schema.y_axis.visible},
      y_axis: Map.from_struct(schema.y_axis),
      # %{align_tricks: schema.z_axis.align_tricks, alternate_grid_color: schema.z_axis.alternate_grid_color, datetime_labelformat: schema.z_axis.datetime_labelformat, id: schema.z_axis.id, labels: schema.z_axis.labels, opposite: schema.z_axis.opposite, title: schema.z_axis.title, type: schema.z_axis.type, vendor: schema.z_axis.vendor, visible: schema.z_axis.visible}
      z_axis: Map.from_struct(schema.z_axis)
    }
  end
end
