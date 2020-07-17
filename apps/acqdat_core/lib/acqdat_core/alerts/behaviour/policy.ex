defmodule AcqdatCore.Alerts.Behaviour.Policy do
  @moduledoc """
  Policy behaviour which model a general overview of how each policy will be defined

  While creating any policy this policy behaviour's function need to be implemented so
  that all the policies will have a same outlook.
  """

  @typedoc """
  `rule name`: when any policy implements this behaviour it needs to return the Policy name.
  `eligible`: inside that policy before implementing that policy it needs to check the eligibility of that
              policy with respect to the current value we received
  `rule_preferences`: every policy will have a set of rule data upon which it will act or implements it's policy.The eligibility of any value will be
                      checked with respect to this rule_preferences
  """

  @callback rule_name() :: name :: String.t()
  @callback eligible?(preferences :: map, value :: integer) :: true | false
  @callback rule_preferences(params :: map) :: map
end
