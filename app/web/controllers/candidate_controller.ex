defmodule App.CandidateController do
  use App.Web, :controller

  alias App.Candidate
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    candidates = Repo.all(Candidate)
    render(conn, "index.json", data: candidates)
  end

  def create(conn, %{"data" => data = %{"type" => "candidate", "attributes" => _candidate_params}}) do
    changeset = Candidate.changeset(%Candidate{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, candidate} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", candidate_path(conn, :show, candidate))
        |> render("show.json", data: candidate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(App.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    candidate = Repo.get!(Candidate, id)
    render(conn, "show.json", data: candidate)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "candidate", "attributes" => _candidate_params}}) do
    candidate = Repo.get!(Candidate, id)
    changeset = Candidate.changeset(candidate, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, candidate} ->
        render(conn, "show.json", data: candidate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(App.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    candidate = Repo.get!(Candidate, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(candidate)

    send_resp(conn, :no_content, "")
  end

end
