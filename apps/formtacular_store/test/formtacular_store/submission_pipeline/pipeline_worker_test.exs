defmodule FormtacularStore.SubmissionPipeline.PipelineWorkerTest do
  use FormtacularStore.ModelCase

  alias FormtacularStore.Forms
  alias FormtacularStore.SubmissionPipeline.PipelineWorker

  describe "start_link/1" do
    test "sets the ip_* fields on the submission" do
      form = create_form()
      submission = add_submission(form, %{ip_address: "123.54.23.1"})

      {:ok, worker} = PipelineWorker.start_link(form, submission)
      ref = Process.monitor(worker)

      receive do
        {:DOWN, ^ref, :process, ^worker, :normal} ->
          [submission] = Forms.get_submissions(form)

          assert submission.ip_city
          assert submission.ip_region_code
          assert submission.ip_country_code
      end
    end
  end

  defp create_form(params \\ []) do
    params = Enum.into(params, %{})
    default_params = %{name: "my form"}

    {:ok, form} = default_params |> Map.merge(params) |> Forms.create()
    form
  end

  defp add_submission(form, params) do
    default_params = %{form_data: %{"hello" => "world"}}
    params = default_params |> Map.merge(params)

    {:ok, submission} = Forms.store_submission(form, params)
    submission
  end
end
