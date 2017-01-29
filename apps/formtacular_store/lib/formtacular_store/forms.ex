defmodule FormtacularStore.Forms do
  import Ecto
  alias FormtacularStore.Forms.Submission
  alias FormtacularStore.Repo

  def store_submission(form, params) do
    form
    |> build_assoc(:submissions)
    |> Submission.changeset(params)
    |> Repo.insert
  end
end
