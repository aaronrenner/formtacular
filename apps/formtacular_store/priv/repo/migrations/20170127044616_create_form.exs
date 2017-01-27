defmodule FormtacularStore.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:forms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :"character varying", null: false

      timestamps()
    end
  end
end
