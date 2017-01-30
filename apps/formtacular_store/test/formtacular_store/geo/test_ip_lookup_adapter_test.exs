defmodule FormtacularStore.Geo.TestIpLookupAdapterTest do
  use ExUnit.Case, async: true

  alias FormtacularStore.Geo.TestIpLookupAdapter
  alias FormtacularStore.Geo.IpLocationResult

  describe "lookup/2" do
    test "with a valid ip address" do
      ip_address = "1.1.1.1"

      {:ok, result} = TestIpLookupAdapter.lookup(ip_address)

      assert result == %IpLocationResult{
        ip_address: ip_address,
        city: "Durango",
        country_code: "US",
        region_code: "CO"
      }
    end
  end
end
