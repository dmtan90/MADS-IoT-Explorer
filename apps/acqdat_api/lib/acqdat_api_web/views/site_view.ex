defmodule AcqdatApiWeb.SiteView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.SiteView

  def render("site.json", %{site: site}) do
    %{
      id: site.id,
      name: site.name
    }
  end

  def render("index.json", site) do
    %{
      sites: render_many(site.entries, SiteView, "site.json"),
      page_number: site.page_number,
      page_size: site.page_size,
      total_entries: site.total_entries,
      total_pages: site.total_pages
    }
  end
end
