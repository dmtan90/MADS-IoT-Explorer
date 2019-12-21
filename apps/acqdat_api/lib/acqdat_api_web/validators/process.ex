defmodule AcqdatApiWeb.Validators.Process do
  use Params

  defparams(
    verify_process_params(%{
      name!: :string,
      site_id!: :integer
    })
  )

  defparams(
    verify_index_params(%{
      page_size: :integer,
      page_number: :integer
    })
  )
end
