defmodule AcqdatCore.Model.DashboardManagement.Dashboard do
  import Ecto.Query
  alias AcqdatCore.DashboardManagement.Schema.Dashboard
  alias AcqdatCore.Model.DashboardManagement.WidgetInstance, as: WidgetInstanceModel
  alias AcqdatCore.Model.DashboardManagement.CommandWidget
  alias AcqdatCore.Repo

  def create(params) do
    changeset = Dashboard.changeset(%Dashboard{}, params)
    Repo.insert(changeset)
  end

  def update(dashboard, params) do
    changeset = Dashboard.update_changeset(dashboard, params)
    Repo.update(changeset)
  end

  def delete(dashboard) do
    Repo.delete(dashboard)
  end

  def get_by_id(id) when is_integer(id) do
    case Repo.get(Dashboard, id) do
      nil ->
        {:error, "dashboard with this id not found"}

      dashboard ->
        {:ok, dashboard}
    end
  end

  def get_by_uuid(uuid) when is_binary(uuid) do
    query =
      from(dashboard in Dashboard,
        where: dashboard.uuid == ^uuid
      )

    case List.first(Repo.all(query)) do
      nil ->
        {:error, "dashboard with this uuid not found"}

      dashboard ->
        {:ok, dashboard |> Repo.preload([:panels, :dashboard_export])}
    end
  end

  def get_with_panels(id) when is_integer(id) do
    case Repo.get(Dashboard, id) |> Repo.preload([:panels, :dashboard_export]) do
      nil ->
        {:error, "dashboard with this id not found"}

      dashboard ->
        {:ok, dashboard}
    end
  end

  def get_all(%{
        page_size: page_size,
        page_number: page_number,
        org_id: org_id
      }) do
    query =
      from(dashboard in Dashboard,
        where: dashboard.org_id == ^org_id and dashboard.archived == false,
        order_by: dashboard.name
      )

    query |> Repo.paginate(page: page_number, page_size: page_size)
  end

  def get_all_archived(%{
        page_size: page_size,
        page_number: page_number,
        org_id: org_id
      }) do
    query =
      from(dashboard in Dashboard,
        where: dashboard.org_id == ^org_id and dashboard.archived == true,
        order_by: dashboard.name
      )

    query |> Repo.paginate(page: page_number, page_size: page_size)
  end
end
