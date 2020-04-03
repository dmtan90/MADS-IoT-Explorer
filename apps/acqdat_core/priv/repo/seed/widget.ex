defmodule AcqdatCore.Seed.Widget do
  @moduledoc """
  Holds seeds for initial widgets.
  """
  alias AcqdatCore.Repo
  alias AcqdatCore.Widgets.Schema.WidgetType
  alias AcqdatCore.Widgets.Schema.Vendors.HighCharts

  @highchart_key_widget_settings %{
    line: %{
      visual: %{
        chart: [type: %{value: 'line'}, backgroundColor: %{}, plotBackgroundColor: %{}],
        title: [:text, :align],
        caption: [:text, :align],
        subtitle: [:text, :align],
        yAxis: [title: [:text]],
      },
      data: %{
        axes: [x: %{multiple: false}, y: %{multiple: true}],
        series: [:name, :color]
      }
    }
  }

  @high_chart_value_settings %{
    line: %{
      visual_setting_values: %{
        title: %{text: 'Solar Employment growth by year'},
        caption: %{
           text: "A brief description of the data being stored by
                the chart here."
        },
        subtitle: %{
          text: 'Source: thesolarfoundation.com'
        },
        yAxis: %{
          title: %{
            text: 'Number of Employees'
          }
        }
      },
      data_settings_values: %{
        series: [
          %{
            name: 'Installation',
            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
          }, %{
            name: 'Manufacturing',
            data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
          }, %{
            name: 'Sales & Distribution',
            data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
          }, %{
            name: 'Project Development',
            data: ['null', 'null', 7988, 12169, 15112, 22452, 34400, 34227]
          }, %{
            name: 'Other',
            data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
          }
        ]
     }
    }
  }

  def seed_widget_types() do
    params = %{
      name: "Highcharts",
      vendor: "Highcharts",
      module: "Elixir.AcqdatCore.Widgets.Schema.Vendors.HighCharts",
      vendor_metadata: %{}
    }

    changeset = WidgetType.changeset(%WidgetType{}, params)
    {:ok, widget_type} = Repo.insert(changeset)
    widget_type
  end

  def seed_widgets(widget_type) do
    @highchart_key_widget_settings
    |> Enum.map(fn {key, widget_settings} ->
      set_widget_data(key, widget_settings, @high_chart_value_settings[key],
        widget_type)
    end)

  end

  def set_widget_data(key, widget_settings, data, widget_type) do
    %{
      label: to_string(key),
      properties: %{},
      uuid: UUID.uuid1(:hex),
      image_url: "https://assets.highcharts.com/images/demo-thumbnails/highcharts/line-basic-default.png",
      category: ["chart", "line"],
      policies: %{},
      widget_type_id: widget_type.id,
      visual_settings: do_settings(key, widget_settings),
      data_settings: do_settings(key, widget_settings),
      default_values: data[key]
    }
  end

  def do_settings(key, %{visual: settings}) do
    require IEx
    IEx.pry

  end

  def do_settings(key, %{data: settings}) do

  end
end
