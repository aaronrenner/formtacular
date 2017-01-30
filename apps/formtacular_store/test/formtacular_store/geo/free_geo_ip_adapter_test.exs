defmodule FormtacularStore.Geo.FreeGeoIpAdapterTest do
  use FormtacularStore.HttpCase, async: true

  alias FormtacularStore.Geo.{FreeGeoIpAdapter, IpLocationResult}

  setup [:start_bypass]

  describe "lookup/2" do
    test "with a successful response", %{bypass: bypass} do
      ip_address = "8.8.8.8"

      Bypass.expect bypass, fn conn ->
        assert conn.request_path == "/json/#{ip_address}"
        response = %{
          ip: ip_address,
          country_code: "US",
          country_name: "United States",
          region_code: "CA",
          region_name: "California",
          city: "Mountain View",
          zip_code: "940305",
          time_zone: "America/Los Angeles",
          latitude: 37.386,
          longitude: -122.0838,
          metro_code: 807
        } |> Poison.encode!

        Plug.Conn.send_resp(conn, 200, response)
      end

      {:ok, result} = FreeGeoIpAdapter.lookup(ip_address, base_url: bypass_url(bypass))

      assert result == %IpLocationResult{
        ip_address: ip_address,
        country_code: "US",
        region_code: "CA",
        city: "Mountain View",
      }
    end

    test "with a 403 response", %{bypass: bypass} do
      ip_address = "8.8.8.8"

      Bypass.expect bypass, fn conn ->
        Plug.Conn.send_resp(conn, 403, "")
      end

      assert {:error, :over_rate_limit} = FreeGeoIpAdapter.lookup(ip_address, base_url: bypass_url(bypass))
    end

    test "with a 404 response", %{bypass: bypass} do
      ip_address = "8.8.8.8"

      Bypass.expect bypass, fn conn ->
        Plug.Conn.send_resp(conn, 404, "")
      end

      assert {:error, :invalid_ip} = FreeGeoIpAdapter.lookup(ip_address, base_url: bypass_url(bypass))
    end

    test "with a 500 response", %{bypass: bypass} do
      ip_address = "8.8.8.8"

      Bypass.expect bypass, fn conn ->
        Plug.Conn.send_resp(conn, 500, "reason")
      end

      assert {:error, :server_error} = FreeGeoIpAdapter.lookup(ip_address, base_url: bypass_url(bypass))
    end

    test "with unable to connect error", %{bypass: bypass} do
      ip_address = "8.8.8.8"

      Bypass.down(bypass)

      assert {:error, _error} = FreeGeoIpAdapter.lookup(ip_address, base_url: bypass_url(bypass))
    end
  end
end
