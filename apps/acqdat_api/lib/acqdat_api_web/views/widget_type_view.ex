defmodule AcqdatApiWeb.WidgetTypeView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.WidgetSettingsView

  def render("widget_type.json", %{widget_type: widget_type}) do
    %{
      id: widget_type.id,
      vendor: widget_type.vendor,
      schema: render_one(widget_type.schema, WidgetSettingsView, "schema.json"),
      vendor_metadata: widget_type.vendor_metadata
    }
  end
end
