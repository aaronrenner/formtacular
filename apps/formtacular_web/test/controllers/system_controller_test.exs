defmodule FormtacularWeb.SystemControllerTest do
  use FormtacularWeb.ConnCase, async: true

  setup %{conn: conn} do
    [conn: put_req_header(conn, "accept", "application/json")]
  end

  describe "GET health_check" do
    test "returns a successful response", %{conn: conn} do
      conn = get conn, system_path(conn, :health_check)

      assert json_response(conn, :ok)
    end
  end
end
