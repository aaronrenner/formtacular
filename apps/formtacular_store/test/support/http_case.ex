defmodule FormtacularStore.HttpCase do
  @moduledoc """
  This module is for http client test cases that use bypass
  """
  use ExUnit.CaseTemplate

  using do
    quote do
      import FormtacularStore.HttpCase

      setup [:start_bypass]
    end
  end

  def start_bypass(_) do
    [bypass: Bypass.open]
  end

  def bypass_url(bypass) do
    "http://localhost:#{bypass.port}"
  end
end
