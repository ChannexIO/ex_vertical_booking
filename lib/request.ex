defmodule ExVerticalBooking.Request do
  @moduledoc "Get HTTP request after validation payload"
  alias ExVerticalBooking.Response.Parser

  @spec send({String.t(), map()}, map(), keyword()) ::
          {:ok, map(), map()} | {:error, map(), map()}
  def send(params, credentials, headers \\ [])

  def send({document, %{success: true} = meta}, %{endpoint: endpoint}, headers) do
    {_, payload} =
      response =
      HTTPoison.post(endpoint, document, headers, timeout: 60_000, recv_timeout: 120_000)

    with {:ok, parsed_response} <- Parser.handle_response(response) do
      {:ok, parsed_response,
       Map.merge(meta, %{
         response: payload.body,
         headers: payload.headers,
         finished_at: DateTime.utc_now(),
         request: document
       })}
    else
      {:error, reason} ->
        {:error, response,
         Map.merge(meta, %{
           success: false,
           errors: [reason],
           finished_at: DateTime.utc_now(),
           request: document
         })}
    end
  end

  def send({document, %{success: false} = meta}, _, _opts) do
    {:error, document, Map.merge(meta, %{success: false, errors: meta.errors})}
  end

  def send({:error, document, meta}, _, _opts) do
    {:error, document, Map.merge(meta, %{success: false, errors: meta.errors})}
  end

  def send({document, meta}, _, _opts) do
    {:error, document, Map.merge(meta, %{success: false, errors: [:invalid_endpoint]})}
  end
end
