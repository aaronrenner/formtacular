defmodule FormtacularStore.Geo.TestIpLookupAdapter do
  @behaviour FormtacularStore.Geo.IpLookupAdapter

  alias FormtacularStore.Geo.IpLocationResult

  def lookup(ip_address, _opts \\ []) do
    result = %IpLocationResult{
      ip_address: ip_address,
      city: "Durango",
      region_code: "CO",
      country_code: "US",
    }

    {:ok, result}
  end
end
