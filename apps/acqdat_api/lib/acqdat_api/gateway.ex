defmodule AcqdatApi.Gateway do
  import AcqdatApiWeb.Helpers
  alias AcqdatCore.Model.Gateway, as: GatewayModel

  def create(params) do
    %{
      name: name,
      configuration: configuration,
      site_id: site_id,
      image_url: image_url
    } = params

    verify_gateway(
      GatewayModel.create(%{
        name: name,
        configuration: configuration,
        site_id: site_id,
        image_url: image_url
      })
    )
  end

  defp verify_gateway({:ok, gateway}) do
    {:ok,
     %{
       id: gateway.id,
       name: gateway.name,
       configuration: gateway.configuration,
       site_id: gateway.site_id,
       last_config_update: gateway.last_config_update,
       image_url: gateway.image_url
     }}
  end

  defp verify_gateway({:error, gateway}) do
    {:error, %{error: extract_changeset_error(gateway)}}
  end
end
