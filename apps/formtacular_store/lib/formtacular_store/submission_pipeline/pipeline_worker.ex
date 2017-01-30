defmodule FormtacularStore.SubmissionPipeline.PipelineWorker do
  @moduledoc """
  This worker manages the entire data enhancement and notification pipeline
  for an individual submission.
  """
  use GenServer

  alias FormtacularStore.{Forms, Geo, Notifications}
  alias FormtacularStore.Forms.Submission

  # Public API

  def start_link(form, submission) do
    GenServer.start_link(__MODULE__, [form, submission])
  end

  def run(pid) do
    GenServer.cast(pid, :run)
  end

  # Callbacks
  def init([form, submission]) do
    self() |> run()
    {:ok, [form, submission]}
  end

  def handle_cast(:run, [form, submission]) do
    {:ok, submission} = import_ip_location_data(form,submission)

    Notifications.notify_new_submission(form, submission)

    # Once pipeline is done, stop.
    {:stop, :normal, [form, submission]}
  end

  defp import_ip_location_data(form, %Submission{ip_address: ip_address} = submission) when is_nil(ip_address), do: {:ok, submission}
  defp import_ip_location_data(form, submission) do
    {:ok, result} = Geo.lookup_ip(submission.ip_address)

    Forms.update_submission_from_ip_location_result(form, submission, result)
  end
end
