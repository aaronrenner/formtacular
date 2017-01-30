defmodule FormtacularStore.Notifications.EmailsTest do
  use ExUnit.Case, async: true

  alias FormtacularStore.Forms.Form
  alias FormtacularStore.Notifications.Emails

  describe "submission_email/2" do
    test "generates an email with all of the submission data" do
      form = %Form{}
      submission = %{form_data: %{"hello" => "world"}, ip_address: "17.2.6.3"}

      email = Emails.submission_email(form, submission)

      assert email.subject =~ "New Submission"
      assert email.html_body =~ "hello"
      assert email.html_body =~ "world"
      assert email.html_body =~ "17.2.6.3"
      assert email.text_body =~ "hello"
      assert email.text_body =~ "world"
      assert email.text_body =~ "17.2.6.3"
    end

    test "without an ip" do
      form = %Form{}
      submission = %{form_data: %{"hello" => "world"}, ip_address: nil}

      email = Emails.submission_email(form, submission)

      assert email.text_body =~ "IP Address: N/A"
      assert email.html_body =~ "IP Address: N/A"
    end
  end
end
