defmodule AcqdatCore.Schema.Settings do
  @moduledoc """
    Embedded Schema of the settings of the widget with it keys and subkeys
  """
  use AcqdatCore.Schema

  embedded_schema do
    field(:chart, :boolean, default: false)
    field(:caption, :boolean, default: false)
    field(:color_axis, :boolean, default: false)
    field(:credits, :boolean, default: false)
    field(:exporting, :boolean, default: false)
    field(:navigation, :boolean, default: false)
    field(:legend, :boolean, default: false)
    field(:pane, :boolean, default: false)
    field(:plot_options, :boolean, default: false)
    field(:responsive, :boolean, default: false)
    field(:subtitle, :boolean, default: false)
    field(:time, :boolean, default: false)
    field(:title, :boolean, default: false)
    field(:tool_tip, :boolean, default: false)
    field(:x_axis, :boolean, default: false)
    field(:y_axis, :boolean, default: false)
    field(:z_axis, :boolean, default: false)
    field(:series, :boolean, default: false)
  end
end
