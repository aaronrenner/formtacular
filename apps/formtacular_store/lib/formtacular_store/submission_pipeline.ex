defmodule FormtacularStore.SubmissionPipeline do
  @moduledoc """
  Pipeline for processing form submissions after they have been stored.

  This pipeline allows for background processing of submissions once they've
  been stored, and also helps to isolate failures coming from data enhancment
  services.
  """

  alias FormtacularStore.Forms.{Form, Submission}

  @doc """
  Enqueues a new submission in the pipeline
  """
  def enqueue(%Form{}=form, %Submission{} = submission) do
    FormtacularStore.SubmissionPipeline.Supervisor.start_pipeline(form, submission)
  end
end
