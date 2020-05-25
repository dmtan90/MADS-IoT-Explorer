defmodule AcqdatApiWeb.EntityManagement.ProjectController do
  use AcqdatApiWeb, :controller
  alias AcqdatCore.Model.EntityManagement.Project, as: ProjectModel
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.EntityManagement.Project

  def index(conn, params) do
    changeset = verify_index_params(params)

    case conn.status do
      nil ->
        {:extract, {:ok, data}} = {:extract, extract_changeset_data(changeset)}
        {:list, project} = {:list, ProjectModel.get_all(data, [])}

        conn
        |> put_status(200)
        |> render("index.json", project)

      404 ->
        conn
        |> send_error(404, "Resource Not Found")
    end
  end
end
