defmodule FormtacularWeb.PublicSubmissionController do
  use FormtacularWeb.Web, :controller

  plug RemoteIp

  def create(conn, %{"form_id" => form_id} = params) do
    form = FormtacularStore.get_form!(form_id)
    submission_params = build_submission_params(conn, params)

    case FormtacularStore.record_submission(form, submission_params) do
      {:ok, _submission} ->
        conn
        |> send_resp(:created, "")
      {:error, _changeset} ->
        conn
        |> send_resp(:unprocessable_entity, "")
    end
  end

  defp build_submission_params(conn, params) do
    %{
      form_data: params |> sanitize_params(),
      ip_address: conn.remote_ip |> ignore_local_loopback_ip |> ip_to_string
    }
  end

  defp sanitize_params(params) do
    Map.drop(params, ["form_id", "utf8"])
  end

  defp ip_to_string(ip_address) when is_tuple(ip_address) do
    ip_address |> Tuple.to_list |> Enum.join(".")
  end
  defp ip_to_string(nil), do: nil

  defp ignore_local_loopback_ip({127, 0, 0, 1}), do: nil
  defp ignore_local_loopback_ip(value), do: value
end
