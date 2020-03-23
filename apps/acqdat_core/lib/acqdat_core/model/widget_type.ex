defmodule AcqdatCore.Model.WidgetType do
  alias AcqdatCore.Schema.WidgetType
  alias AcqdatCore.Repo
  alias AcqdatCore.Model.Helper, as: ModelHelper
  import Ecto.Query

  def create(params) do
    changeset = WidgetType.changeset(%WidgetType{}, params)
    Repo.insert(changeset)
  end

  def get(id) when is_integer(id) do
    case Repo.get(WidgetType, id) do
      nil ->
        {:error, "not found"}

      widget_type ->
        {:ok, widget_type}
    end
  end

  def delete(widget_type) do
    Repo.delete(widget_type)
  end
end
