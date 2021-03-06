defmodule AcqdatCore.Widgets.Schema.Vendors.CustomCards do
  alias AcqdatCore.Model.EntityManagement.SensorData

  @moduledoc """
    Embedded Schema of the settings of the widget with it keys and subkeys
  """
  @data_types ~w(string color object list integer boolean)a

  defstruct card: %{
              data_type: :object,
              user_controlled: false,
              properties: %{
                type: %{data_type: :string, default_value: "", user_controlled: false},
                backgroundColor: %{
                  data_type: :color,
                  default_value: "#ffffff",
                  user_controlled: true
                },
                font: %{data_type: :string, default_value: "#ffffff", user_controlled: true}
              }
            },
            title: %{
              data_type: :object,
              user_controlled: false,
              properties: %{
                text: %{data_type: :string, default_value: "", user_controlled: true},
                align: %{data_type: :string, default_value: "center", user_controlled: true}
              }
            },
            unit: %{
              data_type: :object,
              user_controlled: false,
              properties: %{
                text: %{data_type: :string, default_value: "", user_controlled: true},
                align: %{data_type: :string, default_value: "center", user_controlled: true}
              }
            },
            icon: %{
              data_type: :object,
              user_controlled: false,
              properties: %{
                text: %{data_type: :string, default_value: "", user_controlled: true},
                align: %{data_type: :string, default_value: "center", user_controlled: true}
              }
            },
            description: %{
              data_type: :object,
              user_controlled: false,
              properties: %{
                text: %{data_type: :string, default_value: "", user_controlled: true},
                align: %{data_type: :string, default_value: "center", user_controlled: true}
              }
            },
            series: %{
              data_type: :list,
              user_defined: false,
              properties: %{}
            }
end
