defmodule App.CandidateControllerTest do
  use App.ConnCase

  alias App.Candidate
  alias App.Repo

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, candidate_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = get conn, candidate_path(conn, :show, candidate)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{candidate.id}"
    assert data["type"] == "candidate"
    assert data["attributes"]["name"] == candidate.name
    assert data["attributes"]["age"] == candidate.age
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, candidate_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, candidate_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "candidate",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Candidate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, candidate_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "candidate",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = put conn, candidate_path(conn, :update, candidate), %{
      "meta" => %{},
      "data" => %{
        "type" => "candidate",
        "id" => candidate.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Candidate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = put conn, candidate_path(conn, :update, candidate), %{
      "meta" => %{},
      "data" => %{
        "type" => "candidate",
        "id" => candidate.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = delete conn, candidate_path(conn, :delete, candidate)
    assert response(conn, 204)
    refute Repo.get(Candidate, candidate.id)
  end

end
