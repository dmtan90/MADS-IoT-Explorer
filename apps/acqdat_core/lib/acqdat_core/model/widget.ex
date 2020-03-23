defmodule AcqdatCore.Model.Widget do
  alias AcqdatCore.Schema.Widget
  alias AcqdatCore.Repo
  alias AcqdatCore.Model.Helper, as: ModelHelper
  import Ecto.Query

  def create(params) do
    changeset = Widget.changeset(%Widget{}, params)
    Repo.insert(changeset)
  end

  def get(id) when is_integer(id) do
    case Repo.get(Widget, id) do
      nil ->
        {:error, "not found"}

      widget ->
        {:ok, widget}
    end
  end

  def delete(widget) do
    Repo.delete(widget)
  end
end
