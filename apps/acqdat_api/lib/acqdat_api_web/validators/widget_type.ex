defmodule AcqdatApiWeb.Validators.WidgetType do
  use Params

  defparams(
    verify_widget_type_params(%{
      vendor!: :string,
      schema!: :map,
      vendor_metadata!: :map
    })
  )

  defparams(
    verify_index_params(%{
      page_size: :integer,
      page_number: :integer
    })
  )
end
