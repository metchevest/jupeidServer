# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Juserver.Repo.insert!(%Juserver.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Juserver.Repo

alias Juserver.Accounts
alias Juserver.{Accounts.User, Activities.Class}
alias Juserver.Gorups.{Affiliate, Group, Payment}

c1 = %Class{activity: "yoga", day: "Monday", hour: 16.00} |> Repo.insert()
c2 = %Class{activity: "yoga", day: "Thursday", hour: 16.00} |> Repo.insert()
c3 = %Class{activity: "artistico", day: "Wednesdays", hour: 18.00} |> Repo.insert()
c4 = %Class{activity: "artistico", day: "Friday", hour: 18.00} |> Repo.insert()
c5 = %Class{activity: "meditacion", day: "Tuesday", hour: 19.00} |> Repo.insert()
c6 = %Class{activity: "meditacion", day: "Tuesday", hour: 19.00} |> Repo.insert()

%User{
  facebook_id: "lsafjdlsafjkslfjda223123ds",
  fantasy_name: "Clara Soule Yoga",
  month_income: 0.00,
  name: "Clara Soule"
}
|> Repo.insert!()
|> Accounts.new_group_to_user(%{cost: 1800.00})

# group1 = %Group{cost: 1800.00}

# group2 = %Group{cost: 1900.00}

# afc1 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
# afc2 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
# afc3 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
# afc4 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()

# class1 = %Class{activity: "yoga", day: "Monday", hour: 16.00} |> Repo.insert()

# class2 = %Class{activity: "yoga", day: "Monday", hour: 16.00} |> Repo.insert()

# user2 = %User{facebook_id: "fsdafs213dsfdsf546", fantasy_name: "Pam Yoga", month_income: 0.00, name: "Pamela Plantrose"} |> Repo.insert!()

# g1 = %Group{cost: 1200.00}
# g2 = %Group{cost: 1300.00}

# afp1 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
# afp2 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
# afp3 = %Affiliate{name: "Mauricio", email: "mauricioet@gmail.com"} |> Repo.insert!()
