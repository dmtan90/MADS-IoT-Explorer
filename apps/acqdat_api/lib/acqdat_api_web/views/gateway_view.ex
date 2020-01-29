defmodule AcqdatApiWeb.GatewayView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.GatewayView
  alias AcqdatApiWeb.SiteView

  def render("gateway.json", %{gateway: gateway}) do
    %{
      id: gateway.id,
      name: gateway.name,
      configuration: gateway.configuration,
      last_config_update: gateway.last_config_update,
      site_id: gateway.site_id,
      image_url: gateway.image_url
    }
  end

  def render("gateway_with_preloads.json", %{gateway: gateway}) do
    %{
      id: gateway.id,
      name: gateway.name,
      configuration: gateway.configuration,
      last_config_update: gateway.last_config_update,
      site_id: gateway.site_id,
      image_url: gateway.image_url,
      site: render_one(gateway.site, SiteView, "site.json")
    }
  end

  def render("index.json", gateway) do
    %{
      gateways: render_many(gateway.entries, GatewayView, "gateway_with_preloads.json"),
      page_number: gateway.page_number,
      page_size: gateway.page_size,
      total_entries: gateway.total_entries,
      total_pages: gateway.total_pages
    }
  end
end
