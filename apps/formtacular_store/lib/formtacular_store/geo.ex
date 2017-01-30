defmodule FormtacularStore.Geo do
  @moduledoc """
  Internal geocoding api
  """

  def lookup_ip(ip_address) do
    adapter().lookup(ip_address)
  end

  defp adapter do
    :formtacular_store
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:adapter)
  end
end
