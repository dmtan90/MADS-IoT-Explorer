defmodule AcqdatCore.Alerts.AlertCreationTest do
  @moduledoc """
  Alert creation logics will be tested here
  """
  use ExUnit.Case, async: true
  use AcqdatCore.DataCase
  alias AcqdatCore.Schema.IotManager.Gateway
  alias AcqdatCore.Model.IotManager.Gateway, as: GModel
  alias AcqdatCore.Alerts.AlertCreation
  alias AcqdatCore.Alerts.Model.AlertRules
  alias AcqdatCore.Schema.IotManager.GatewayDataDump
  alias AcqdatIot.DataParser
  import AcqdatCore.Support.Factory
  alias AcqdatCore.Repo

  describe "create/1" do
    setup :setup_alert_rules

    @doc """
    Here alert rule is created from sensor parameters so this parameters will be passed to gateway for mapping the parameters so that on
    data dump is done we can have a parameter uuid mapped to gateway to generate a alert.
    """
    @tag timeout: :infinity
    test "create alert", %{alert_rule: alert_rules, sensor: sensor} do
      {:ok, alert_rules} = AlertRules.create(alert_rules)
      gateway = setup_gateway(sensor)
      data_dump = dump_iot_data(gateway)
      DataParser.start_parsing(data_dump)
    end
  end

  @doc """
  Here the gateway is inserted in such a wap that mapped parameter will have sensor id and sensor parameter uuid which with threashold value greater then
  Upper limit.
  """
  def setup_gateway(sensor) do
    org = insert(:organisation)
    project = insert(:project, org: org)
    asset = insert(:asset, org: org, project: project)
    gateway = insert_gateway(org, project, asset)
    gateway = insert_mapped_parameters(gateway, sensor)
  end

  defp insert_gateway(org, project, asset) do
    params = %{
      uuid: UUID.uuid1(:hex),
      name: "Gateway",
      access_token: "1yJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9",
      slug: "hbGciOiJIUzUxMiIsInR5cCI6I",
      org_id: org.id,
      project_id: project.id,
      parent_id: asset.id,
      parent_type: "Asset",
      channel: "http",
      streaming_data: [
        %{
          name: "Gateway Parameter 1",
          data_type: "integer",
          unit: "cm",
          uuid: UUID.uuid1(:hex)
        },
        %{
          name: "Gateway Parameter 2",
          data_type: "integer",
          unit: "m",
          uuid: UUID.uuid1(:hex)
        }
      ],
      static_data: []
    }

    changeset = Gateway.changeset(%Gateway{}, params)
    Repo.insert!(changeset)
  end

  def setup_alert_rules(_context) do
    sensor = insert(:sensor)
    parameters = fetch_parameters(sensor.sensor_type.parameters)
    [user1, user2, user3] = insert_list(3, :user)

    alert_rule = %{
      entity: "sensor",
      entity_id: sensor.id,
      policy_name: "Elixir.AcqdatCore.Alerts.Policies.RangeBased",
      entity_parameters: parameters,
      uuid: UUID.uuid1(:hex),
      communication_medium: ["in-app, sms, e-mail"],
      slug: Slugger.slugify(random_string(12)),
      rule_parameters: %{lower_limit: 10, upper_limit: 20},
      recepient_ids: [user1.id, user2.id],
      assignee_ids: [user3.id],
      policy_type: ["user"],
      severity: "warning",
      status: "un_resolved",
      app: "iot_manager",
      project_id: sensor.project_id,
      creator_id: user1.id
    }

    [alert_rule: alert_rule, sensor: sensor]
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  defp fetch_parameters(parameters) do
    Enum.reduce(parameters, [], fn param, acc ->
      acc ++ [Map.from_struct(param)]
    end)
  end

  defp insert_mapped_parameters(gateway, sensor) do
    [param1, param2] = sensor.sensor_type.parameters

    mapped_parameters = %{
      "y_axis" => %{
        "type" => "value",
        "entity" => "sensor",
        "entity_id" => sensor.id,
        "value" => param1.uuid
      }
    }

    {:ok, gateway} = GModel.update(gateway, %{mapped_parameters: mapped_parameters})
    gateway
  end

  defp dump_iot_data(gateway) do
    params = %{
      gateway_id: gateway.id,
      org_id: gateway.org_id,
      project_id: gateway.project_id,
      data: %{
        "y_axis" => 21
      },
      inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
      inserted_timestamp: DateTime.truncate(DateTime.utc_now(), :second)
    }

    changeset = GatewayDataDump.changeset(%GatewayDataDump{}, params)
    {:ok, data_dump} = Repo.insert(changeset)
    data_dump
  end
end
