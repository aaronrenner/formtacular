defmodule FormtacularWeb.Router do
  use FormtacularWeb.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormtacularWeb do
    pipe_through :api

    post "/f/:form_id", PublicSubmissionController, :create
    get "/health_check", SystemController, :health_check
  end
end
