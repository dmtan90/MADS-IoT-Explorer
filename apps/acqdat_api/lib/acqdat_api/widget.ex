defmodule AcqdatApi.Widget do
  alias AcqdatCore.Model.Widget, as: WidgetModel
  import AcqdatApiWeb.Helpers

  def create(params) do
    %{
      name: name,
      author: author,
      properties: properties,
      settings: settings
    } = params

    verify_widget(
      WidgetModel.create(%{
        name: name,
        author: author,
        properties: properties,
        settings: settings
      })
    )
  end

  defp verify_widget({:ok, widget}) do
    {:ok,
     %{
       id: widget.id,
       name: widget.name,
       properties: widget.properties,
       settings: widget.settings,
       uuid: widget.uuid
     }}
  end

  defp verify_widget({:error, message}) do
    {:error, %{error: extract_changeset_error(message)}}
  end
end
