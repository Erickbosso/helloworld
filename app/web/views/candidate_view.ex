defmodule App.CandidateView do
  use App.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :age, :inserted_at, :updated_at]
  

end
