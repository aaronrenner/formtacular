defmodule FormtacularStore.Forms.Form do
  @moduledoc """
  An individual form that receives submissions
  """
  use FormtacularStore.Model
  alias FormtacularStore.Forms.Submission

  schema "forms" do
    field :name, :string
    has_many :submissions, Submission

    timestamps()
  end

  @doc """
  Creates a changeset from a struct and the given params
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
