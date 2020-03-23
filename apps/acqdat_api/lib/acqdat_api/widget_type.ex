defmodule AcqdatApi.WidgetType do
  alias AcqdatCore.Model.WidgetType, as: WidgetTypeModel
  import AcqdatApiWeb.Helpers

  def create(params) do
    %{
      vendor: vendor,
      schema: schema,
      vendor_metadata: vendor_metadata
    } = params

    verify_widget_type(
      WidgetTypeModel.create(%{
        vendor: vendor,
        schema: schema,
        vendor_metadata: vendor_metadata
      })
    )
  end

  defp verify_widget_type({:ok, widget_type}) do
    {:ok,
     %{
       id: widget_type.id,
       vendor: widget_type.vendor,
       schema: widget_type.schema,
       vendor_metadata: widget_type.vendor_metadata
     }}
  end

  defp verify_widget_type({:error, message}) do
    {:error, %{error: extract_changeset_error(message)}}
  end
end
