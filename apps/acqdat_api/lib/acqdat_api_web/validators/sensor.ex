defmodule AcqdatApiWeb.Validators.Sensor do
  use Params

  defparams(
    verify_sensor_params(%{
      gateway_id!: :integer,
      aesthetic_name!: :string,
      telemetry_attributes!: {:array, :string},
      metadata: :map,
      description: :string,
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
