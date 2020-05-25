defmodule AcqdatApiWeb.EntityManagement.ProjectView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.EntityManagement.AssetView
  alias AcqdatApiWeb.EntityManagement.SensorView
  alias AcqdatApiWeb.EntityManagement.ProjectView

  def render("project.json", %{project: project}) do
    params =
      render_many(project.sensors, SensorView, "sensor_tree.json") ++
        render_many(project.assets, AssetView, "asset_tree.json")

    %{
      type: "Project",
      id: project.id,
      name: project.name,
      archived: project.archived,
      slug: project.slug,
      description: project.description,
      version: project.version,
      entities: params
    }
  end

  def render("index.json", project) do
    %{
      projects: render_many(project.entries, ProjectView, "project_index.json"),
      page_number: project.page_number,
      page_size: project.page_size,
      total_entries: project.total_entries,
      total_pages: project.total_pages
    }
  end

  def render("project_index.json", %{project: project}) do
    %{
      type: "Project",
      id: project.id,
      name: project.name,
      archived: project.archived,
      slug: project.slug,
      description: project.description,
      version: project.version
    }
  end
end
