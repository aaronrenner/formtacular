defmodule FormtacularStore.Notifications.EmailsTest do
  use ExUnit.Case, async: true

  alias FormtacularStore.Forms.Form
  alias FormtacularStore.Notifications.Emails

  describe "submission_email/2" do
    test "generates an email with all of the submission data" do
      form = %Form{}
      submission = %{form_data: %{"hello" => "world"}}

      email = Emails.submission_email(form, submission)

      assert email.subject =~ "New Submission"
      assert email.html_body =~ "hello"
      assert email.html_body =~ "world"
      assert email.text_body =~ "hello"
      assert email.text_body =~ "world"
    end
  end
end
