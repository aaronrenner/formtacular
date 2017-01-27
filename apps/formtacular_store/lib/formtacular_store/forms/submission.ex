defmodule FormtacularStore.Forms.Submission do
  @moduledoc """
  An individual form submission
  """
  use FormtacularStore.Model

  alias FormtacularStore.Forms.Form

  schema "submissions" do
    belongs_to :form, Form
    field :form_data, :map

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:form_data])
    |> validate_required([:form_data])
  end
end
