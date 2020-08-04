import EctoEnum

# creates a policy definition enum. The schema enum
# contains the name of the module which will define the module
# contianing all the key definitions for a alert policy.
defenum(PolicyDefinitionModuleEnum,
  "Elixir.AcqdatCore.Alerts.Policies.RangeBased": 0
)

# Creates an enum for different policy definitions.
defenum(PolicyDefinitionEnum,
  RangeBasedPolicy: 0
)
