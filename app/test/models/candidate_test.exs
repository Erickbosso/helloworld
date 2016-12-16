defmodule App.CandidateTest do
  use App.ModelCase

  alias App.Candidate

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Candidate.changeset(%Candidate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Candidate.changeset(%Candidate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
