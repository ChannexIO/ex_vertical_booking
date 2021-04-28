defmodule ExVerticalBooking.Request do
  @moduledoc "Get HTTP request after validation payload"

  use HTTPClient
  alias ExVerticalBooking.Response.Parser

  @spec send({String.t(), map()}, map(), keyword()) ::
          {:ok, map(), map()} | {:error, map(), map()}
  def send(params, credentials, headers \\ [{"Content-Type", "application/xml"}], attempt \\ 0)

  def send(
        {document, %{success: true} = meta} = params,
        %{endpoint: endpoint} = credentials,
        headers,
        attempt
      ) do
    {_, payload} =
      response = post(endpoint, document, headers, timeout: 120_000, recv_timeout: 240_000)

    with {:ok, parsed_response} <- Parser.handle_response(response) do
      {:ok, parsed_response,
       Map.merge(meta, %{
         response: payload.body,
         headers: Enum.map(payload.headers, &Tuple.to_list/1),
         finished_at: DateTime.utc_now(),
         request: document
       })}
    else
      {:error, :closed} ->
        if attempt < 10 do
          Process.sleep(1_500)
          Logger.log(:info, "VerticalBooking: Repeat send request, #{attempt} attempt")
          send(params, credentials, headers, attempt + 1)
        else
          Logger.log(:info, "VerticalBooking: Fail after #{attempt} attempts")

          {:error, response,
           Map.merge(meta, %{
             success: false,
             errors: [:closed],
             finished_at: DateTime.utc_now(),
             request: document
           })}
        end

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

  def send({document, %{success: false} = meta}, _, _opts, _) do
    {:error, document, Map.merge(meta, %{success: false, errors: meta.errors})}
  end

  def send({:error, document, meta}, _, _opts, _) do
    {:error, document, Map.merge(meta, %{success: false, errors: meta.errors})}
  end

  def send({document, meta}, _, _opts, _) do
    {:error, document, Map.merge(meta, %{success: false, errors: [:invalid_endpoint]})}
  end
end
