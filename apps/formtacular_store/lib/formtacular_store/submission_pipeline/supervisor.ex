defmodule FormtacularStore.SubmissionPipeline.Supervisor do
  use Supervisor

  alias FormtacularStore.SubmissionPipeline.PipelineWorker

  # Public API

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_pipeline(form, submission) do
    Supervisor.start_child(__MODULE__, [form, submission])
  end

  # Callback API
  def init([]) do
    children = [
      worker(PipelineWorker, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
