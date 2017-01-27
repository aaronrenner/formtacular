defmodule FormtacularStore.Forms.SubmissionTest do
  use FormtacularStore.ModelCase, async: true
  alias FormtacularStore.Forms.Submission

  describe "changeset/2" do
    test "with valid params" do
      changeset =
        %Submission{}
        |> Submission.changeset(%{form_data: %{test: "something"}})

      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = %Submission{} |> Submission.changeset(%{})

      refute changeset.valid?
    end

    test "does not allow a blank form data" do
      assert {:form_data, "can't be blank"} in errors_on(%Submission{}, %{})
    end
  end
end
