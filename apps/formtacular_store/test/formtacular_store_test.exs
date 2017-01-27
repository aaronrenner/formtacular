defmodule FormtacularStoreTest do
  use FormtacularStore.ModelCase

  describe "create_form/1" do
    test "with valid params" do
      form = create_form(name: "Sample form")

      assert form.id
      assert form.name == "Sample form"
    end

    test "with invalid params" do
      assert {:error, _changeset} = FormtacularStore.create_form(%{name: ""})
    end
  end

  describe "get_form!/1" do
    test "when a form id is found" do
      %{id: form_id} = create_form()

      assert %{id: ^form_id } = FormtacularStore.get_form!(form_id)
    end

    test "when a form id is not found" do
      assert_raise Ecto.NoResultsError, fn ->
        FormtacularStore.get_form!(Ecto.UUID.generate)
      end
    end
  end


  describe "record_submission/2" do
    test "with valid params" do
      form = create_form()
      form_data = %{"email" => "jdoe@example.com"}

      {:ok, submission} = FormtacularStore.record_submission(form,
                            %{"form_data" => form_data})

      assert submission.id
      assert submission.form_data == form_data
    end

    test "with invalid params" do
      form = create_form()

      assert {:error, _changeset} = FormtacularStore.record_submission(form,%{})
    end
  end

  describe "get_submissions/2" do
    test "returns the form submissions" do
      form = create_form()
      %{id: submission_id} = add_submission(form)

      assert [%{id: ^submission_id}] = FormtacularStore.get_submissions(form)
    end
  end

  defp create_form(params \\ []) do
    params = Enum.into(params, %{})
    default_params = %{name: "my form"}

    {:ok, form} =
      default_params |> Map.merge(params) |> FormtacularStore.create_form()
    form
  end

  defp add_submission(form) do
    {:ok, submission} = FormtacularStore.record_submission(form,
                          %{"form_data" => %{"hello" => "world"}})
    submission
  end
end
