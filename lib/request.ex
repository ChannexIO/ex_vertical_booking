defmodule ExVerticalBooking.Request do
  alias ExVerticalBooking.Response.Parser

  @endpoint Application.get_env(:ex_vertical_booking, :endpoint)

  def send(document, meta) do
    {_, payload} = response = HTTPoison.post(@endpoint, document, [], [])
    parsed_response = Parser.handle_response(response)

    meta =
      meta
      |> Map.put(:finished_at, DateTime.utc_now())
      |> Map.put(:request, document)

    with {:ok, parsed_response} <- parsed_response do
      {:ok, parsed_response, meta |> Map.put(:response, payload.body)}
    else
      {:error, reason} ->
        {:error, response, meta |> Map.put(:success, false) |> Map.put(:errors, reason)}
    end
  end
end
