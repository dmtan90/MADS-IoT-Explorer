defmodule AcqdatApiWeb.Validators.Widget do
  use Params

  defparams(
    verify_widget_params(%{
      name!: :string,
      author!: :string,
      properties: :map,
      settings: :map
    })
  )

  defparams(
    verify_index_params(%{
      page_size: :integer,
      page_number: :integer
    })
  )
end
