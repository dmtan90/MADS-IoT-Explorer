defmodule AcqdatCore.Widgets.Schema.Vendors.HighCharts do
  @moduledoc """
    Embedded Schema of the settings of the widget with it keys and subkeys
  """
  @data_types ~w(string color object list integer boolean)a

  defstruct [
    chart: %{
      data_type: :object,
      user_controlled: false,
      properties:
      %{
        type: %{data_type: :string, default_value: ""},
        backgroundColor: %{data_type: :color, default_value: "#ffffff", user_controlled: true},
        borderColor: %{data_type: :color, default_value: "#335cad", user_controlled: true},
        plotBackgroundColor: %{data_type: :string, default_value: "", user_controlled: true},
        height: %{data_type: :string, default_value: "", user_controlled: false},
        width: %{data_type: :string, default_value: "", user_controlled: false}
     },
    },

    caption: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        text: %{data_type: :string, default_value: "", user_controlled: true},
        align: %{data_type: :string, default_value: "left", user_controlled: true},
      },
    },

    color_axis: %{
      data_type: :list,
      user_controlled: false,
      properties: %{
        min: %{data_type: :integer, default_value: 0, user_controlled: false},
        max: %{data_type: :integer, default_value: 0, user_controlled: false},
        layout: %{data_type: :string, default_value: "horizontal", user_controlled: false},
      },
    },

    credits: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        enabled: %{data_type: :boolean, default: false, user_controlled: false}
      },
    },

    exporting: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        enabled: %{data_type: :boolean, default: false, user_controlled: false}
      }
    },

    legend: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        enabled: %{data_type: :boolean, default: false, user_controlled: false},
        layout: %{data_type: :string, default: "right", user_controlled: true},
        align: %{data_type: :string, default: "right", user_controlled: true},
        verticalAlign: %{data_type: :string, default: "middle", user_controlled: true},
      }
    },

    navigation: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        menuStyle: %{data_type: :object, default: %{}, user_controlled: false},
        menuItemHoverStyle: %{data_type: :object, default: %{}, user_controlled: false}
      }
    },

    pane: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        size: %{data_type: :string, default: "85%", user_controlled: false},
        background: %{data_type: :list, properties: %{
          backgroundColor: %{data_type: :string,
            default: "{ linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, stops: [[0, #ffffff], [1, #e6e6e6]]}",
            user_controlled: false
          },
          borderColor: %{data_type: :color, default: "#cccccc", user_controlled: false},
          innerRadius: %{data_type: :string, default: "0", user_controlled: false},
          outerRadius: %{data_type: :string, default: "", user_controlled: false},
        }},
        startAngle: %{data_type: :integer, default: 0, user_controlled: true},
        endAngle: %{data_type: :integer, default: 0, user_controlled: true}
      }
    },

    plotOptions: %{
      data_type: :object,
      user_controlled: false
    },

    responsive: %{
      user_controlled: false,
      data_type: :object,
      rules: %{
          data_type: :list,
          properties: %{
            condition: %{
              data_type: :object,
              maxHeight: %{data_type: :integer, default: 0, user_controlled: false},
              maxWidth: %{data_type: :integer, default: 0, user_controlled: false},
              minHeight: %{data_type: :integer, default: 0, user_controlled: false},
              minWidth: %{data_type: :integer, default: 0, user_controlled: false}
            }
          }
       }
    },

    subtitle: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        text: %{data_type: :string, default: "", user_controlled: true},
        style: %{data_type: :object, default: %{}, user_controlled: false},
        align: %{data_type: :string, default: "center", user_controlled: true},
      }
    },

    time: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        timezone: %{data_type: :string, default: "", user_controlled: false},
        useUTC: %{data_type: :boolean, default: true, user_controlled: false},
      }
    },

    title: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        text: %{data_type: :string, default: "", user_controlled: true},
        style: %{data_type: :object, default: %{}, user_controlled: false},
        align: %{data_type: :string, default: "center", user_controlled: true},
      }
    },

    tooltip: %{
      data_type: :object,
      user_controlled: false,
      properties: %{
        backgroundColor: %{data_type: :string, default: "", user_controlled: true},
        valuePrefix: %{data_type: :string, default: "", user_controlled: true},
        valueSuffix: %{data_type: :string, default: "", user_controlled: true},
        pointFormat: %{data_type: :string, default: "center", user_controlled: false},
      }
    },

    xAxis: %{
      data_type: :list,
      user_controlled: false,
      properties: %{
        alignTricks: %{data_type: :boolean, default: true, user_controlled: false},
        alternateGridColor: %{data_type: :color, default: "", user_controlled: true},
        dateTimeLabelFormats: %{data_type: :object, default: %{}, user_controlled: false},
        labels: %{data_type: :object, default: %{}, user_controlled: false},
        title: %{
          data_type: :object, default: %{}, user_controlled: false,
          properties: %{
            text: %{data_type: :string, default: "", user_controlled: true},
          }
        },
        visible: %{data_type: :boolean, default: true, user_controlled: false},
        type: %{data_type: :string, default: true, user_controlled: true},
        min: %{data_type: :integer, default: "null", user_controlled: true},
        max: %{data_type: :integer, default: "null", user_controlled: true},
        plotBands: %{data_type: :list, default: %{}, user_controlled: true}
      }
    },

    yAxis: %{
      data_type: :list,
      user_controlled: false,
      properties: %{
        alignTricks: %{data_type: :boolean, default: true, user_controlled: false},
        alternateGridColor: %{data_type: :color, default: "", user_controlled: true},
        dateTimeLabelFormats: %{data_type: :object, default: %{}, user_controlled: false},
        labels: %{data_type: :object, default: %{}, user_controlled: false},
        title: %{
          data_type: :object, default: %{}, user_controlled: false,
          properties: %{
            text: %{data_type: :string, default: "", user_controlled: true},
          }
        },
        visible: %{data_type: :boolean, default: true, user_controlled: false},
        type: %{data_type: :string, default: true, user_controlled: true},
        min: %{data_type: :integer, default: "null", user_controlled: true},
        max: %{data_type: :integer, default: "null", user_controlled: true},
        plotBands: %{data_type: :list, default: %{}, user_controlled: true}
      }
    },

    zAxis: %{
      data_type: :list,
      user_controlled: false,
      properties: %{
        alignTricks: %{data_type: :boolean, default: true, user_controlled: false},
        alternateGridColor: %{data_type: :color, default: "", user_controlled: true},
        dateTimeLabelFormats: %{data_type: :object, default: %{}, user_controlled: false},
        labels: %{data_type: :object, default: %{}, user_controlled: false},
        title: %{
          data_type: :object, default: %{}, user_controlled: false,
          properties: %{
            text: %{data_type: :string, default: "", user_controlled: true},
          }
        },
        visible: %{data_type: :boolean, default: true, user_controlled: false},
        type: %{data_type: :string, default: true, user_controlled: true},
        min: %{data_type: :integer, default: "null", user_controlled: true},
        max: %{data_type: :integer, default: "null", user_controlled: true},
        plotBands: %{data_type: :list, default: %{}, user_controlled: true}
      }
    },

    series: %{
      data_type: :list,
      user_defined: false,
      properties: %{}
    }
  ]


  @doc """
  Takes data in the form of axes and series and arranges the data
  in the format specified by highcharts.

  The `axes` map has data by axes name and it's values.

  """

  @spec arrange_series_structure(map, list) :: map
  def arrange_series_structure(axes, series) do

  end
end
