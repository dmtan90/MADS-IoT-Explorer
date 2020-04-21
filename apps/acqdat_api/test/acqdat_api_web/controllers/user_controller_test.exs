defmodule AcqdatApiWeb.UserControllerTest do
  use ExUnit.Case, async: true
  use AcqdatApiWeb.ConnCase
  use AcqdatCore.DataCase
  import AcqdatCore.Support.Factory

  describe "show/2" do
    setup :setup_conn

    test "fails if authorization header not found", %{conn: conn} do
      bad_access_token = "avcbd123489u"
      org = insert(:organisation)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{bad_access_token}")

      conn = get(conn, Routes.organisation_user_path(conn, :show, org.id, 1))
      result = conn |> json_response(403)
      assert result == %{"errors" => %{"message" => "Unauthorized"}}
    end

    test "user with invalid organisation id", %{conn: conn} do
      insert(:user)
      org = insert(:organisation)

      conn = get(conn, Routes.organisation_user_path(conn, :show, org.id, -1))
      result = conn |> json_response(400)
      assert result == %{"errors" => %{"message" => "not found"}}
    end

    test "user with valid id", %{conn: conn} do
      user = insert(:user)
      org = insert(:organisation)

      params = %{
        id: user.id
      }

      conn = get(conn, Routes.organisation_user_path(conn, :show, org.id, params.id))
      result = conn |> json_response(200)

      assert result["id"] == user.id
    end
  end
end
