defmodule FormtacularStore.Forms do
  @moduledoc """
  Internal API for interacting with forms
  """

  import Ecto
  import Ecto.Changeset
  alias FormtacularStore.Forms.{Form, Submission}
  alias FormtacularStore.Geo.IpLocationResult
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

  @doc """
  Updates a submission from an IpLocationResult
  """
  def update_submission_from_ip_location_result(_form, submission,
    %IpLocationResult{} = ip_location_result) do

    submission
    |> change()
    |> put_change(:ip_city, ip_location_result.city)
    |> put_change(:ip_region_code, ip_location_result.region_code)
    |> put_change(:ip_country_code, ip_location_result.country_code)
    |> Repo.update
  end
end
