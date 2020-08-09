defmodule AcqdatCore.Alerts.Policies.RangeBased do
  @moduledoc """
  This module will define range base policy.
  So if any entity implements this policy as an alert rule for a particular parameter. it has to five lower and upper limit value.
  If that parameters value at the time of data parsing falls into this lower and upper limit then that alert rule will generate an alert
  depending upon the severity.
  """
  use AcqdatCore.Schema
  alias AcqdatCore.Alerts.Behaviour.Policy
  @behaviour Policy

  @type t :: %__MODULE__{}
  @rule "RangeBasedPolicy"
  @decimal_zero Decimal.from_float(0.0)

  embedded_schema do
    field(:lower_limit, :decimal, default: 0.0)
    field(:upper_limit, :decimal, default: 0.0)
  end

  def changeset(%__MODULE__{} = rule, params) do
    rule
    |> cast(params, [:lower_limit, :upper_limit])
  end

  ############################# BEHAVIOURS IMPLEMENTATION ####################################

  @doc """
  It is implementing the rule name function of the policy and will be returning the policy name.
  """
  @impl Policy
  def rule_name() do
    @rule
  end

  @doc """
  So this rule preference will pass the map which will take a param from alert rule and accordingly create a rule preference which
  will be stored in the alert rules table so that the entity over which this policy is user will act on values extracted from this rule_preference
  """
  @impl Policy
  def rule_preferences() do
    [
      %{
        key: :lower_limit,
        type: :input
      },
      %{
        key: :upper_limit,
        type: :input
      }
    ]
  end

  @doc """
  Here preferences will have lower limit and upper limit and accordingly we will check for 4 condition inside check_eligibility function
  """
  @impl Policy
  def eligible?(preferences, value) do
    lower_limit = Decimal.new(preferences["lower_limit"])
    upper_limit = Decimal.new(preferences["upper_limit"])
    value = Decimal.new(value)
    check_eligibility?(lower_limit, upper_limit, value)
  end

  # This is for the case when both our limit comes as zero
  defp check_eligibility?(@decimal_zero, @decimal_zero, _), do: false

  # This is for the case when upper limit is zero so basically we are checking for greater then lower limit criteria.
  defp check_eligibility?(lower_limit, @decimal_zero, value) do
    case Decimal.cmp(lower_limit, value) do
      :lt ->
        true

      :eq ->
        true

      _ ->
        false
    end
  end

  # This is for the case when lower limit is zero so basically we are checking for lesser then upper limit criteria
  defp check_eligibility?(@decimal_zero, upper_limit, value) do
    case Decimal.cmp(value, upper_limit) do
      :lt ->
        false

      :eq ->
        true

      _ ->
        true
    end
  end

  # This is for the range case where value falls for lower and upper limit

  defp check_eligibility?(lower_limit, upper_limit, value) do
    value_lower =
      case Decimal.cmp(lower_limit, value) do
        :lt ->
          true

        :eq ->
          true

        _ ->
          false
      end

    value_upper =
      case Decimal.cmp(upper_limit, value) do
        :gt ->
          true

        :eq ->
          true

        _ ->
          false
      end

    value_lower && value_upper
  end

  # defp validate_embedded_data(%Ecto.Changeset{valid?: true} = changeset) do
  #   {:ok, rule_values} = fetch_change(changeset, :rule_values)

  #   rule_values
  #   |> run_rule_validations()
  #   |> data_reduce_filter(changeset)
  #   |> case do
  #     %Ecto.Changeset{} = changeset ->
  #       changeset

  #     %{} = data ->
  #       put_change(changeset, :rule_values, data)
  #   end
  # end

  # defp validate_embedded_data(changeset), do: changeset

  # defp run_rule_validations(rule_values) do
  #   Enum.map(rule_values, fn {key, value} ->
  #     module = value["module"] |> String.to_existing_atom()

  #     changeset = module.changeset(struct(module), value["preferences"])

  #     case add_preferences_change(key, changeset, value["module"]) do
  #       {:ok, _data} = result ->
  #         result

  #       {:error, _info} = result ->
  #         result
  #     end
  #   end)
  # end

  # defp data_reduce_filter(enumerable, changeset) do
  #   Enum.reduce_while(enumerable, %{}, fn
  #     {:ok, {key, value}}, acc ->
  #       {:cont, Map.put(acc, key, value)}

  #     {:error, {key, value}}, _acc ->
  #       value = map_error(key, value)
  #       changeset = add_error(changeset, :rule_values, value)
  #       {:halt, changeset}
  #   end)
  # end

  # defp add_preferences_change(key, %Ecto.Changeset{valid?: true} = embed_changeset, module) do
  #   data = embed_changeset.changes
  #   {:ok, module} = PolicyMap.dump(module)
  #   {:ok, {"#{key}", %{"preferences" => data, "module" => module}}}
  # end

  # defp add_preferences_change(key, pref_changeset, _module) do
  #   additional_info =
  #     pref_changeset
  #     |> traverse_errors(fn {msg, opts} ->
  #       Enum.reduce(opts, msg, fn {key, value}, acc ->
  #         String.replace(acc, "%{#{key}}", to_string(value))
  #       end)
  #     end)

  #   {:error, {"#{key}", additional_info}}
  # end

  # defp map_error(key, error_data) do
  #   Jason.encode!(Map.put(%{}, key, error_data))
  # end
end
