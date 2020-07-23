defmodule AcqdatCore.Alerts.Schema.AlertRules do
  @moduledoc """
  AlertRules are the rules which an entity follows before creating alerts.
  """

  use AcqdatCore.Schema
  alias AcqdatCore.Schema.EntityManagement.Project
  alias AcqdatCore.Schema.RoleManagement.User

  @typedoc """
  `entity`: entity name for which this alert rule is defined example: "sensor", "gateway"
  `entity_id`:  "id" for that entity
  `policy_name`:  policy name which this alert rule follow like "RangeBased"
  `entity_parameters`: will hold parameters of that entity for which this alert rule is applicable
  `rule_parameters`: rule parameters will hold the parameters with their values that is required for that policy to work on.
  `policy_type`: policy type can be of two type user level or project level
  `description`: description of this alert rule
  `project`:  project id this alert rule is related to.
  `creator`: creator is the one which is creating this alert rule for the following project, this will be used for adding filter on who can create alert rule.
  """

  schema "acqdat_alert_rules" do
    field(:entity, :string, null: false)
    field(:entity_id, :integer, null: false)
    field(:policy_name, :string, null: false)
    field(:entity_parameters, :map, null: false)
    field(:uuid, :string, null: false)
    field(:slug, :string, null: false)
    field(:rule_parameters, :map, null: false)
    field(:policy_type, {:array, :string})

    field(:description, :string)

    # Associations
    belongs_to(:project, Project, on_replace: :delete)
    belongs_to(:creator, User, on_replace: :delete)

    timestamps(type: :utc_datetime)
  end

  @required_params ~w(entity entity_id policy_name uuid slug entity_parameters rule_parameters policy_type project_id creator_id)a
  @optional_params ~w(description)a

  @permitted_params @required_params ++ @optional_params

  def changeset(%__MODULE__{} = alert_rule, params) do
    alert_rule
    |> cast(params, @permitted_params)
    |> add_uuid()
    |> add_slug()
    |> validate_required(@required_params)
    |> common_changeset()
  end

  def common_changeset(changeset) do
    changeset
    |> assoc_constraint(:project)
    |> assoc_constraint(:creator)
    |> unique_constraint(:slug, name: :acqdat_alert_rules_slug_index)
    |> unique_constraint(:uuid, name: :acqdat_alert_rules_uuid_index)
  end

  defp add_uuid(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:uuid, UUID.uuid1(:hex))
  end

  defp add_slug(%Ecto.Changeset{valid?: true} = changeset) do
    changeset
    |> put_change(:slug, Slugger.slugify(random_string(12)))
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
