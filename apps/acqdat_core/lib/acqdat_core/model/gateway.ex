defmodule AcqdatCore.Model.Gateway do
  import Ecto.Query
  alias AcqdatCore.Repo
  alias AcqdatCore.Schema.Gateway
  alias AcqdatCore.Model.Helper, as: ModelHelper

  def create(params) do
    changeset = Gateway.changeset(%Gateway{}, params)
    Repo.insert(changeset)
  end

  def update(gateway, params) do
    changeset = Gateway.update_changeset(gateway, params)
    Repo.update(changeset)
  end

  def get_all() do
    Repo.all(Gateway)
  end

  def get_all(%{page_size: page_size, page_number: page_number}) do
    Gateway |> order_by(:id) |> Repo.paginate(page: page_number, page_size: page_size)
  end

  def get_all(%{page_size: page_size, page_number: page_number}, preloads) do
    paginated_gateway_data =
      Gateway |> order_by(:id) |> Repo.paginate(page: page_number, page_size: page_size)

    gateway_data_with_preloads = paginated_gateway_data.entries |> Repo.preload(preloads)

    ModelHelper.paginated_response(gateway_data_with_preloads, paginated_gateway_data)
  end

  def delete(id) do
    Gateway
    |> Repo.get(id)
    |> Repo.delete()
  end

  def get(id) when is_integer(id) do
    case Repo.get(Gateway, id) do
      nil ->
        {:error, "not found"}

      gateway ->
        {:ok, gateway}
    end
  end

  def get(query) when is_map(query) do
    case Repo.get_by(Gateway, query) do
      nil ->
        {:error, "not found"}

      gateway ->
        {:ok, gateway}
    end
  end
end
