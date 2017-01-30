defmodule FormtacularStore.Forms do
  @moduledoc """
  Internal API for interacting with forms
  """

  import Ecto
  alias FormtacularStore.Forms.{Form, Submission}
  alias FormtacularStore.Repo

  @doc """
  Creates a new form with the given params
  """
  def create(params) do
    %Form{} |> Form.changeset(params) |> Repo.insert
  end

  @doc """
  Gets the form for the given id. If no form is found,
  it raises an Ecto.NoResultsError
  """
  def get!(form_id) do
    Form |> Repo.get!(form_id)
  end

  @doc """
  Stores a submission on a form
  """
  def store_submission(form, params) do
    form
    |> build_assoc(:submissions)
    |> Submission.changeset(params)
    |> Repo.insert
  end

  @doc """
  Gets all submissions for a given form.
  """
  def get_submissions(form) do
    form |> assoc(:submissions) |> Repo.all
  end
end
