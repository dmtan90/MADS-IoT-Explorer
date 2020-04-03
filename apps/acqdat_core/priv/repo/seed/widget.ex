defmodule AcqdatCore.Seed.Widget do
  @moduledoc """
  Holds seeds for initial widgets.
  """

  @highchart_key_widget_settings %{
    line: {
      visual: %{
        chart: [type: %{value: 'line'}, :backgroundColor, :plotBackgroundColor],
        title: [:text, :align],
        caption: [:text, :align],
        subtitle: [:text, :align],
        yAxis: [title: [:text]],
      }
      data: %{
        axes: [x: %{multiple: false}, y: %{multiple: true}],
        series: [:name, :color]
      }
    }
  }

  @high_chart_value_settings %{
    line: %{
      visual_setting_values: %{
        title: %{'Solar Employment growth by year'}},
        caption: %{
           text: "A brief description of the data being stored by
                the chart here."
        }
        subtitle: %{
          text: 'Source: thesolarfoundation.com'
        },
        yAxis: %{
          title: {
            text: 'Number of Employees'
          }
        }
      },
      data_settings_values: %{
        x: [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017],
        y: [
          [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
          [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434],
          [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387],
          [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
        ],
        series: [
          %{name: "Installation"},
          %{name: "Manufacturing"},
          %{name: "Sales & Distribution"},
          %{name: "Project Development"}
        ]
    }
  }
end
