defmodule FormtacularStore.Forms.Submission do
  @moduledoc """
  An individual form submission
  """
  use FormtacularStore.Model

  alias FormtacularStore.Forms.Form

  schema "submissions" do
    belongs_to :form, Form
    field :form_data, :map
    field :ip_address, :string

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:form_data, :ip_address])
    |> validate_required([:form_data])
  end
end
