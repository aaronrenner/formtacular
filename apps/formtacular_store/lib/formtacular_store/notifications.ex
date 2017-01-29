defmodule FormtacularStore.Notifications do
  @moduledoc """
  Internal module that handles sending notifications
  """
  alias FormtacularStore.Notifications.Emails
  alias FormtacularStore.Mailer

  def notify_new_submission(form, submission) do
    form |> Emails.submission_email(submission) |> Mailer.deliver_later
  end
end
