# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias App.Repo  
alias App.Candidate

[
  %Candidate{
    name: "Erick",
    age: 35
  },
  %Candidate{
    name: "Liane",
    age: 30
  },
%Candidate{
    name: "Marcos",
    age: 31
  }

] |> Enum.each(&Repo.insert!(&1))