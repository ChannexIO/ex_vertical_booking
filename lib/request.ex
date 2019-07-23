defmodule ExVerticalBooking.Request do
  alias ExVerticalBooking.Response.Parser

  def send({document, %{success: true} = meta}, %{endpoint: endpoint}) do
    {_, payload} = response = HTTPoison.post(endpoint, document, [], [])
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

  def send({document, %{success: false} = meta}, _) do
    {:error, document, meta |> Map.put(:success, false) |> Map.put(:errors, meta.errors)}
  end
  def send({document, meta}, _) do
    {:error, document, meta |> Map.put(:success, false) |> Map.put(:errors, :invalid_endpoint)}
  end
end
