defmodule FormtacularStore.Geo.FreeGeoIpAdapter do
  @behaviour FormtacularStore.Geo.IpLookupAdapter

  alias FormtacularStore.Geo.IpLocationResult

  @doc """
  Look up the location details on freegeoip.com
  """
  def lookup(ip_address, opts \\ []) do
    base_url = Keyword.get_lazy(opts, :base_url, &default_base_url/0)
    request_url = Path.join([base_url, "json", ip_address])

    case HTTPoison.get(request_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, build_lookup_response(body)}
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        {:error, :over_rate_limit}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :invalid_ip}
      {:ok, %HTTPoison.Response{status_code: 500}} ->
        {:error, :server_error}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Unable to connecto to server: #{reason |> to_string}"}
    end
  end

  defp build_lookup_response(body) do
    json = Poison.decode!(body)

    %IpLocationResult{
      ip_address: json["ip"],
      city: json["city"],
      region_code: json["region_code"],
      country_code: json["country_code"],
    }
  end

  defp default_base_url do
    :formtacular_store
    |> Application.fetch_env(__MODULE__)
    |> Keyword.fetch!(:base_url)
  end
end
