defmodule FormtacularStore.Notifications.Emails.EmailView do
  use Phoenix.View,
    root: "lib/formtacular_store/notifications/emails/templates",
    namespace: FormtacularStore.Notifications.Emails
  use Phoenix.HTML

  def nil_as_na(nil), do: "N/A"
  def nil_as_na(value), do: value

end
