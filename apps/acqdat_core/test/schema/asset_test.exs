defmodule AcqdatCore.Schema.AssetTest do
  use ExUnit.Case, async: true
  use AcqdatCore.DataCase

  import AcqdatCore.Support.Factory

  alias AcqdatCore.Schema.Asset

  describe "changeset/2" do
    setup do
      organisation = insert(:organisation)
      [organisation: organisation]
    end

    test "returns a valid changeset", context do
      %{organisation: organisation} = context

      params = %{
        name: "Bintan Factory",
        org_id: organisation.id,
        parent_id: organisation.id
      }

      %{valid?: validity} = Asset.changeset(%Asset{}, params)
      assert validity
    end

    test "returns invalid if params empty" do
      %{valid?: validity} = changeset = Asset.changeset(%Asset{}, %{})
      refute validity

      assert %{
               org_id: ["can't be blank"],
               parent_id: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "returns error if assoc constraint not satisfied", _context do
      params = %{
        name: "Bintan Factory",
        org_id: -1,
        parent_id: -1
      }

      changeset = Asset.changeset(%Asset{}, params)

      {:error, result_changeset} = Repo.insert(changeset)
      assert %{org: ["does not exist"]} == errors_on(result_changeset)
    end

    test "returns error if asset with same name exists under a parent" do
      organisation = insert(:organisation)
      parent_asset = insert(:asset, org: organisation)

      child_asset_1 = insert(:asset, org: organisation, parent_id: parent_asset.id)

      params =
        :asset
        |> build(name: child_asset_1.name, org: organisation, parent_id: parent_asset.id)
        |> Map.from_struct()
        |> Map.put(:org_id, organisation.id)

      changeset = Asset.changeset(%Asset{}, params)
      {result, changeset} = Repo.insert(changeset)
      assert result == :error
      assert %{name: ["unique name under hierarchy"]} == errors_on(changeset)
    end

    # TODO: complete the test
    test "returns error if no parent but asset with same name under same org" do
      organisation = insert(:organisation)
      child_asset_1 = insert(:asset, org: organisation)
    end

    # TODO: complete the test
    test "allows insertion of asset with same name under different parents" do
    end
  end
end