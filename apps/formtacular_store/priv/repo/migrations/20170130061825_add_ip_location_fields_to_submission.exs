defmodule FormtacularStore.Repo.Migrations.AddIpLocationFieldsToSubmission do
  use Ecto.Migration

  def change do
    alter table(:submissions) do
      add :ip_city, :string
      add :ip_region_code, :string
      add :ip_country_code, :string
    end
  end
end
