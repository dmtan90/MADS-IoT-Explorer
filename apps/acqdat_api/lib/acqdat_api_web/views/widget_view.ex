defmodule AcqdatApiWeb.WidgetView do
  use AcqdatApiWeb, :view

  def render("widget.json", %{widget: widget}) do
    %{
      id: widget.id,
      name: widget.name,
      properties: widget.properties,
      settings: widget.settings,
      uuid: widget.uuid
    }
  end
end
