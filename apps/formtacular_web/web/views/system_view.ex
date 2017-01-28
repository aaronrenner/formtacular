defmodule FormtacularWeb.SystemView do
  use FormtacularWeb.Web, :view

  def render("health_check.json", _) do
    %{health: "ok"}
  end
end
