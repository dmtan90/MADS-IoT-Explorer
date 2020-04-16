defmodule AcqdatCore.Seed.User do

  alias AcqdatCore.Schema.User
  alias AcqdatCore.Schema.Role
  alias AcqdatCore.Repo

  def seed_user!() do
    role = Repo.get(Role, 1)
    params = %{
      first_name: "Chandu",
      last_name: "Developer",
      email: "chandu@stack-avenue.com",
      password: "datakrew",
      password_confirmation: "datakrew",
      role_id: role.id,
      is_invited: false
    }
    user = User.changeset(%User{}, params)
    Repo.insert!(user, on_conflict: :nothing)
  end
end
