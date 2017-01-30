defmodule FormtacularWeb.PublicSubmissionControllerTest do
  use FormtacularWeb.ConnCase

  alias FormtacularStore.Forms.Submission

  describe "POST create" do
    test "with a valid form id", %{conn: conn} do
      {:ok, form} = FormtacularStore.create_form(%{name: "Sample form"})
      form_data = %{"email" => "hello@example.com"}

      ip_address = "15.2.6.23, 92.47.3.2"

      conn =
        conn
        |> put_req_header("x-forwarded-for", ip_address)
        |> post(public_submission_path(conn, :create, form.id), form_data)

      assert response(conn, :created)

      [%Submission{}=submission] = FormtacularStore.get_submissions(form)
      assert submission.form_data == form_data
      assert submission.ip_address == "92.47.3.2"
    end

    test "with an invalid x-forwarded-for-ip", %{conn: conn} do
      {:ok, form} = FormtacularStore.create_form(%{name: "Sample form"})
      form_data = %{"email" => "hello@example.com"}

      conn =
        conn
        |> put_req_header("x-forwarded-for", "invalid")
        |> post(public_submission_path(conn, :create, form.id), form_data)

      assert response(conn, :created)

      [%Submission{}=submission] = FormtacularStore.get_submissions(form)
      assert submission.form_data == form_data
      assert submission.ip_address == nil
    end

    test "with an unknown form id", %{conn: conn} do
      assert_error_sent :not_found, fn ->
        post conn, public_submission_path(conn, :create, Ecto.UUID.generate), %{}
      end
    end
  end
end
