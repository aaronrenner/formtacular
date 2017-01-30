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
    field :ip_city, :string
    field :ip_region_code, :string
    field :ip_country_code, :string

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:form_data, :ip_address])
    |> validate_required([:form_data])
  end
end
