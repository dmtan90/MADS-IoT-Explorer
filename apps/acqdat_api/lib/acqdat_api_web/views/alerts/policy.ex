defmodule AcqdatApiWeb.Alerts.PolicyView do
  use AcqdatApiWeb, :view
  alias AcqdatApiWeb.Alerts.PolicyView

  def render("policies.json", %{policies: policies}) do
    %{
      policies: render_many(policies, PolicyView, "policy.json")
    }
  end

  def render("policy.json", %{policy: policy}) do
    %{policy: policy}
  end
end
