defmodule FormtacularStore do
  @moduledoc """
  Public API for FormtacularStore
  """

  alias FormtacularStore.{Forms, Notifications}

  @doc """
  Creates a form with the given parameters
  """
  def create_form(params), do: Forms.create(params)

  @doc """
  Gets the form for the given id. If no form is found,
  it raises an Ecto.NoResultsError
  """
  def get_form!(form_id), do: Forms.get!(form_id)

  @doc """
  Records a form submission
  """
  def record_submission(form, params) do
    with {:ok, submission} <- Forms.store_submission(form, params) do
      Notifications.notify_new_submission(form, submission)
      {:ok, submission}
    end
  end

  @doc """
  Gets the submissions for a given form
  """
  def get_submissions(form), do: Forms.get_submissions(form)
end
