defmodule AcqdatCore.Schema.SensorTest do
  use ExUnit.Case, async: true
  use AcqdatCore.DataCase

  import AcqdatCore.Support.Factory

  alias AcqdatCore.Schema.Sensor

  describe "changeset/2" do
    setup do
      device = insert(:device)

      [device: device]
    end

    test "returns a valid changeset", context do
      %{device: device} = context

      params = %{
        uuid: UUID.uuid1(:hex),
        name: "Temperature",
        device_id: device.id
      }

      %{valid?: validity} = Sensor.changeset(%Sensor{}, params)

      assert validity
    end

    test "returns invalid if params empty" do
      %{valid?: validity} = changeset = Sensor.changeset(%Sensor{}, %{})
      refute validity

      assert %{
               device_id: ["can't be blank"],
               name: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error if assoc constraint not satisfied", context do
      params = %{
        uuid: UUID.uuid1(:hex),
        name: "Temperature",
        device_id: -1
      }

      changeset = Sensor.changeset(%Sensor{}, params)

      {:error, result_changeset} = Repo.insert(changeset)
      assert %{device: ["does not exist"]} == errors_on(result_changeset)
    end

    test "returns error if unique constraint not satisified", context do
      %{device: device} = context

      params = %{
        uuid: UUID.uuid1(:hex),
        name: "Temperature",
        device_id: device.id + device.id
      }

      changeset = Sensor.changeset(%Sensor{}, params)
      {:error, result_changeset} = Repo.insert(changeset)
      assert %{device: ["does not exist"]} == errors_on(result_changeset)
    end
  end
end
