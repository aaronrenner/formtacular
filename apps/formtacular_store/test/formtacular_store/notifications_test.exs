defmodule FormtacularStore.NotificationsTest do
  use FormtacularStore.ModelCase, async: true
  use Bamboo.Test

  alias FormtacularStore.Notifications
  alias FormtacularStore.Forms.{Form, Submission}

  describe "notify_new_submission/2" do
    test "sends an email with the form data of the new submission" do
      form = build_form()
      submission = build_submission(form)

      Notifications.notify_new_submission(form, submission)

      assert_delivered_email FormtacularStore.Notifications.Emails.submission_email(form, submission)
    end
  end

  defp build_form() do
    %Form{name: "My Form"}
  end

  defp build_submission(form) do
    %Submission{form: form, form_data: %{"hello" => "world"}}
  end
end
