defmodule AcqdatApiWeb.Validators.Gateway do
  use Params

  defparams(
    verify_gateway_params(%{
      name!: :string,
      configuration!: :map,
      site_id!: :integer,
      last_update_config: :map,
      image_url: :string
    })
  )

  defparams(
    verify_index_params(%{
      page_size: :integer,
      page_number: :integer
    })
  )
end
