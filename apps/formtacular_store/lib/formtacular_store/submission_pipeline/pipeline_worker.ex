defmodule FormtacularStore.SubmissionPipeline.PipelineWorker do
  @moduledoc """
  This worker manages the entire data enhancement and notification pipeline
  for an individual submission.
  """
  use GenServer

  alias FormtacularStore.Notifications

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
    Notifications.notify_new_submission(form, submission)

    # Once pipeline is done, stop.
    {:stop, :normal, [form, submission]}
  end
end
