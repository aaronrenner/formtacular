defmodule FormtacularStore.Repo.Migrations.CreateSubmission do
  use Ecto.Migration

  def change do
    create table(:submissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :form_data, :map
      add :form_id, references(:forms, type: :binary_id), null: false

      timestamps()
    end
    create index(:submissions, [:form_id])
  end
end
