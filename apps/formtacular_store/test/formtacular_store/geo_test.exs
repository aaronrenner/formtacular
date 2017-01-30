defmodule FormtacularStore.GeoTest do
  use ExUnit.Case, async: true

  alias FormtacularStore.Geo
  alias FormtacularStore.Geo.IpLocationResult

  describe "lookup_ip/1" do
    test "returns result from current adapter" do
      assert {:ok, %IpLocationResult{}} = Geo.lookup_ip("1.1.1.1")
    end
  end
end
