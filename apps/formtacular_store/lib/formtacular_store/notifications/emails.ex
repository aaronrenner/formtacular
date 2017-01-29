defmodule FormtacularStore.Notifications.Emails do
  @moduledoc false
  use Bamboo.Phoenix, view: FormtacularStore.Notifications.Emails.EmailView

  @default_from_email "formtacular@animascodelabs.com"

  @doc"""
  Notifies form owner of new submission
  """
  def submission_email(_form, submission) do
    new_email()
    |> from(@default_from_email)
    |> to("aaron@animascodelabs.com")
    |> subject("New Submission")
    |> render(:submission_email, submission: submission)
  end
end
