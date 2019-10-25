defmodule ExVerticalBooking.Request.PCIProxies.PCIBooking do
  alias ExVerticalBooking.Request
  @api_endpoint "https://service.pcibooking.net/api"

  @spec proxy_send({String.t(), map()}, map()) :: {:ok, map(), map()} | {:error, map(), map()}
  def proxy_send({document, %{success: true} = meta}, %{endpoint: endpoint, api_key: api_key}) do
    with {:ok, temp_session} <- start_temporary_session(api_key),
         url <- get_tokenized_booking_url(endpoint, temp_session),
         {:ok, response, meta} <- send_request(url, {document, meta}, api_key),
         pci <- response |> parse_headers(meta) |> convert_token_headers() do
      {:ok, response, Map.put(meta, :pci, pci)}
    end
  end

  def proxy_send(payload, credentials) do
    Request.send(payload, credentials)
  end

  def get_token_meta(token, api_key) do
    token
    |> get_token_meta_url()
    |> HTTPoison.get(headers(api_key))
  end

  defp parse_headers(_, %{headers: headers}) do
    # The direction of the headers sequence is critical!
    %{
      tokens: split(get_from(headers, "X-VERTICALBOOKINGFETCHCC"), ";"),
      errors: split(get_from(headers, "X-pciBooking-Tokenization-Errors"), ";;"),
      warnings: split(get_from(headers, "X-pciBooking-Tokenization-Warnings"), ";;")
    }
  end

  defp split(nil, _delimiter), do: []
  defp split(header, delimiter), do: String.split(header, delimiter)

  defp parse_headers(response, meta) do
    {:error, response,
     Map.merge(meta, %{success: false, errors: ["Response not content any headers" | meta.errors]})}
  end

  defp convert_token_headers(%{tokens: [], errors: [], warnings: []}) do
    []
  end

  defp convert_token_headers(%{tokens: tokens, errors: [], warnings: []}) do
    tokens |> encapsulate_tokens() |> Enum.map(fn {key, value} -> value end)
  end

  defp convert_token_headers(%{tokens: tokens, errors: [], warnings: warnings}) do
    Enum.reduce(tokens, {%{}, 0}, fn token, {map, count} ->
      {Map.put(map, count + 1, token), count + 1}
    end)
  end

  defp encapsulate_tokens(tokens) do
    Enum.reduce(tokens, {%{}, 0}, fn token, {map, count} ->
      {Map.put(map, count + 1, %{token: token}), count + 1}
    end)
  end

  defp get_token_meta_url(token) do
    get_url("https://service.pcibooking.net/api/payments/paycard/meta",
      ref: token |> String.split("/") |> List.last()
    )
  end

  defp get_tokenized_booking_url(endpoint, temp_session) do
    get_url("/payments/paycard/capture",
      sessionToken: temp_session,
      httpMethod: "POST",
      profileName: "VerticalBooking",
      targetURI: endpoint,
      saveCVV: true
      #      eliminateCardDuplication: true
    )
  end

  defp start_temporary_session(api_key) do
    with {:ok, body, _} <-
           send_request("/payments/paycard/tempsession", {"", %{success: true}}, api_key) do
      {:ok, String.replace(body.body, "\"", "")}
    else
      error -> error
    end
  end

  defp get_url(url, arguments) do
    arguments =
      arguments
      |> Enum.reduce(
        [],
        fn {key, value}, acc ->
          acc ++ ["#{key}=#{value}"]
        end
      )
      |> Enum.join("&")

    "#{url}?#{arguments}"
  end

  defp headers(api_key) do
    [
      {"Authorization", "APIKEY #{api_key}"},
      {"Chache-Control", "no-cache"}
    ]
  end

  defp get_from(headers, key) do
    with [{_, item} | _] <- Enum.filter(headers, fn {a, _} -> a == key end) do
      item
    else
      _ -> nil
    end
  end

  defp send_request(url, body, api_key) do
    Request.send(body, %{endpoint: "#{@api_endpoint}#{url}"}, headers(api_key))
  end
end
