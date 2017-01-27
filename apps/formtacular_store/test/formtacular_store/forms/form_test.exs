defmodule FormtacularStore.Forms.FormTest do
  use FormtacularStore.ModelCase, async: true
  alias FormtacularStore.Forms.Form

  describe "changest/2" do
    test "with valid params" do
      changeset = %Form{} |> Form.changeset(%{name: "valid name"})

      assert changeset.valid?
    end

    test "with invalid params" do
      changeset = %Form{} |> Form.changeset(%{})

      refute changeset.valid?
    end

    test "does not allow a blank name field" do
      assert {:name, "can't be blank"} in errors_on(%Form{}, %{})
    end
  end
end
