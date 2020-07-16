# defmodule AcqdatCore.Alerts.Schema.Behaviour.Policy do
# @moduledoc """
# Policy behaviour which model a general overview of how each policy will be defined

# While creating any policy this policy behaviour's function need to be implemented so
# that all the policies will have a same outlook.
# """

# use AcqdatCore.Schema

# @typedoc """
# `rules`: Holds different rules which our system supports with their information and their implementation rules
#        ## Example
#        rules,
#        %{
#          "range" => %{
#            "required" => %{
#              "lower_limit": "value"
#              "upper limit": "value"
#            }},
#          "greater_then" => %{
#            "required" => %{
#              "upper_limit": "value"
#            }},
#          "smaller_then" => %{
#            "required" => %{
#              "lower_limit": "value"
#            }
#          }
#        }
# """
# @type t:: %__MODULE__{}

# @callback rule_name()

# schema("acqdat_alert_policy") do
#   embeds_many :rules, Rules, on_replace: :delete do
#     field :rule_name, :string
#     field :required, :map
#   end
# end

# end
