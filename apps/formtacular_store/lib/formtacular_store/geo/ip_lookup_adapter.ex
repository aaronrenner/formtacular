defmodule FormtacularStore.Geo.IpLookupAdapter do
  alias FormtacularStore.Geo.IpLocationResult

  @callback lookup(String.t, Keyword.t) :: {:ok, IpLocationResult.t} | {:error, :over_rate_limit | :invalid_ip | :server_error | String.t}
end
