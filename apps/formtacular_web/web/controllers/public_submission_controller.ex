defmodule FormtacularWeb.PublicSubmissionController do
  use FormtacularWeb.Web, :controller

  def create(conn, %{"form_id" => form_id} = params) do
    form = FormtacularStore.get_form!(form_id)
    params = sanitize_params(params)

    case FormtacularStore.record_submission(form, %{form_data: params}) do
      {:ok, _submission} ->
        conn
        |> send_resp(:created, "")
      {:error, _changeset} ->
        conn
        |> send_resp(:unprocessable_entity, "")
    end
  end

  defp sanitize_params(params) do
    Map.drop(params, ["form_id", "utf8"])
  end
end
