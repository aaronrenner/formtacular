defmodule FormtacularStore.Repo.Migrations.AddIpAddressToSubmission do
  use Ecto.Migration

  def change do
    alter table(:submissions) do
      add :ip_address, :string
    end
  end
end
