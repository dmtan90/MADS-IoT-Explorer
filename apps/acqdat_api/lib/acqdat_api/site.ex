defmodule AcqdatApi.Site do
  import AcqdatApiWeb.Helpers
  alias AcqdatCore.Model.Site, as: SiteModel

  def create(params) do
    %{
      name: name
    } = params

    verify_site(
      SiteModel.create(%{
        name: name
      })
    )
  end

  defp verify_site({:ok, site}) do
    {:ok,
     %{
       id: site.id,
       name: site.name
     }}
  end

  defp verify_site({:error, site}) do
    {:error, %{error: extract_changeset_error(site)}}
  end
end
