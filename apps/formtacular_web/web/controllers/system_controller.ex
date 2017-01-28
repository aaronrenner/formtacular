defmodule FormtacularWeb.SystemController do
  use FormtacularWeb.Web, :controller

  def health_check(conn, _params) do
    render conn, "health_check.json"
  end
end
