defmodule AcqdatCore.Widgets.Schema.WidgetTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use AcqdatCore.DataCase
  alias AcqdatCore.Test.Support.WidgetData
  alias AcqdatCore.Widgets.Schema.Widget

  setup_all %{} do
    widget_params = WidgetData.data()
    [widget_params: widget_params]
  end

  describe "changeset/2 " do

    test "returns a valid changeset", context do
      %{widget_params: params} = context
      changeset = Widget.changeset(%Widget{}, params)
    end

  end

end
