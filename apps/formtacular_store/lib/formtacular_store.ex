defmodule FormtacularStore do
  @moduledoc """
  Business logic for Formtacular
  """

  alias FormtacularStore.Forms.{Form, Submission}
  alias FormtacularStore.Repo
  import Ecto

  @doc """
  Creates a form with the given parameters
  """
  def create_form(params) do
    %Form{} |> Form.changeset(params) |> Repo.insert
  end

  @doc """
  Gets the form for the given id. If no form is found,
  it raises an Ecto.NoResultsError
  """
  def get_form!(form_id) do
    Form |> Repo.get!(form_id)
  end

  @doc """
  Records a form submission
  """
  def record_submission(form, params) do
    form
    |> build_assoc(:submissions)
    |> Submission.changeset(params)
    |> Repo.insert
  end

  @doc """
  Gets the submissions for a given form
  """
  def get_submissions(form) do
    form |> assoc(:submissions) |> Repo.all
  end
end
