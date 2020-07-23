defmodule AcqdatCore.Alerts.Model.AlertRules do
  @moduledoc """
  Contains CREATE, UPDATE, DELETE, GET and INDEX model functions
  """
  alias AcqdatCore.Repo
  alias AcqdatCore.Alerts.Schema.AlertRules

  @doc """
    create function will prepare the changeset and just insert it into the database
  """
  def create(params) do
    changeset = AlertRules.changeset(%AlertRules{}, params)
    Repo.insert(changeset)
  end

  @doc """
  update function will update the alert rules
  """
  def update(alert_rules, params) do
    changeset = AlertRules.changeset(alert_rules, params)
    Repo.update(changeset)
  end

  @doc """
  delete function will delete the alert rules
  """
  def delete(alert_rules) do
    Repo.delete(alert_rules)
  end

  @doc """
  for fetching a alert rule from the given ID
  """
  def get_by_id(id) when is_integer(id) do
    case Repo.get(AlertRules, id) do
      nil ->
        {:error, "Alert not found"}

      alert_rules ->
        {:ok, alert_rules}
    end
  end
end
