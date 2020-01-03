defmodule AcqdatApiWeb.PlaceController do
  use AcqdatApiWeb, :controller
  alias AcqdatApi.GooglePlaces
  import AcqdatApiWeb.Helpers
  import AcqdatApiWeb.Validators.Place

  def search_location(conn, params) do
    changeset = verify_place_params(params)

    with {:extract, {:ok, data}} <- {:extract, extract_changeset_data(changeset)},
         {:create, {:ok, location_details}} <-
           {:create, GooglePlaces.find_place(data.search_string)} do
      conn
      |> put_status(200)
      |> json(%{"location" => location_details})
    else
      {:extract, {:error, error}} ->
        send_error(conn, 400, error)

      {:create, {:error, message}} ->
        send_error(conn, 400, message)
    end
  end
end
