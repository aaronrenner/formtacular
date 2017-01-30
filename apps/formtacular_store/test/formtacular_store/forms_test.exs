defmodule FormtacularStore.FormsTest do
  use FormtacularStore.ModelCase, async: true

  alias FormtacularStore.Forms
  alias FormtacularStore.Geo.IpLocationResult

  describe "create_form/1" do
    test "with valid params" do
      {:ok, form} = Forms.create(%{name: "Sample form"})

      assert form.id
      assert form.name == "Sample form"
    end

    test "with invalid params" do
      assert {:error, _changeset} = Forms.create(%{name: ""})
    end
  end

  describe "get!/1" do
    test "when a form id is found" do
      %{id: form_id} = create_form()

      assert %{id: ^form_id } = Forms.get!(form_id)
    end

    test "when a form id is not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Forms.get!(Ecto.UUID.generate)
      end
    end
  end

  describe "store_submission/2" do
    test "with valid params" do
      form = create_form()
      form_data = %{"email" => "jdoe@example.com"}

      {:ok, submission} = Forms.store_submission(form,
                            %{"form_data" => form_data})

      assert submission.id
      assert submission.form_data == form_data
    end

    test "with invalid params" do
      form = create_form()

      assert {:error, _changeset} = Forms.store_submission(form,%{})
    end
  end

  describe "get_submissions/2" do
    test "returns the form submissions" do
      form = create_form()
      %{id: submission_id} = add_submission(form)

      assert [%{id: ^submission_id}] = Forms.get_submissions(form)
    end
  end

  describe "update_submission_from_ip_location_result/2" do
    test "with ip location result" do
      form = create_form()
      submission = add_submission(form)
      ip_location_result = %IpLocationResult{
        city: "Durango",
        region_code: "CO",
        country_code: "US"
      }

      {:ok, submission} = Forms.update_submission_from_ip_location_result(form, submission, ip_location_result)

      assert submission.ip_city == ip_location_result.city
      assert submission.ip_region_code == ip_location_result.region_code
      assert submission.ip_country_code == ip_location_result.country_code
    end
  end

  defp create_form(params \\ []) do
    params = Enum.into(params, %{})
    default_params = %{name: "my form"}

    {:ok, form} = default_params |> Map.merge(params) |> Forms.create()
    form
  end

  defp add_submission(form) do
    {:ok, submission} = Forms.store_submission(form,
                          %{"form_data" => %{"hello" => "world"}})
    submission
  end
end
