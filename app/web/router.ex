defmodule App.Router do
  use App.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", App do
    pipe_through :api
    resources "/candidates", CandidateController, except: [:new, :edit]
  end
end
