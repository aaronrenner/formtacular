defmodule FormtacularWeb.PublicSubmissionControllerTest do
  use FormtacularWeb.ConnCase, async: true

  describe "POST create" do
    test "with a valid form id", %{conn: conn} do
      {:ok, form} = FormtacularStore.create_form(%{name: "Sample form"})
      form_data = %{"email" => "hello@example.com"}

      conn = post conn, public_submission_path(conn, :create, form.id), form_data

      assert response(conn, :created)
      [%{form_data: saved_form_data}] = FormtacularStore.get_submissions(form)
      assert saved_form_data == form_data
    end

    test "with an unknown form id", %{conn: conn} do
      assert_error_sent :not_found, fn ->
        post conn, public_submission_path(conn, :create, Ecto.UUID.generate), %{}
      end
    end
  end
end
