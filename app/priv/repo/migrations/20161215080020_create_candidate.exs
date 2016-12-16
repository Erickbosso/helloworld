defmodule App.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :age, :integer

      timestamps()
    end

  end
end
