defmodule App.Candidate do
  use App.Web, :model

  schema "candidates" do
    field :name, :string
    field :age, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age])
    |> validate_required([:name, :age])
  end
end
