defmodule ExVerticalBooking.Request.PCIProxies.PCIBooking do
  alias ExVerticalBooking.Request
  @api_endpoint "https://service.pcibooking.net/api"

  @spec proxy_send({String.t(), map()}, map()) :: {:ok, map(), map()} | {:error, map(), map()}
  def proxy_send({document, %{success: true} = meta}, %{endpoint: endpoint, api_key: api_key}) do
    with {:ok, temp_session} <- start_temporary_session(api_key),
         url <- get_tokenized_booking_url(endpoint, temp_session),
         {:ok, response, meta} <- send_request(url, {document, meta}, api_key) do
      pci =
        with {:ok, meta} <- parse_headers(meta),
             {:ok, pci} <- convert_token_headers(meta) do
          rename_keys(pci)
        end

      {:ok, response, Map.put(meta, :pci, pci)}
    end
  end

  def proxy_send(payload, credentials) do
    Request.send(payload, credentials)
  end

  defp start_temporary_session(api_key) do
    with {:ok, body, _} <-
           send_request("/payments/paycard/tempsession", {"", %{success: true}}, api_key) do
      {:ok, String.replace(body.body, "\"", "")}
    else
      error -> error
    end
  end

  defp get_tokenized_booking_url(endpoint, temp_session) do
    get_url("/payments/paycard/capture",
      sessionToken: temp_session,
      httpMethod: "POST",
      profileName: "VerticalBooking",
      targetURI: endpoint,
      saveCVV: true
    )
  end

  defp send_request(url, body, api_key) do
    Request.send(body, %{endpoint: "#{@api_endpoint}#{url}"}, headers(api_key))
  end

  def parse_headers(%{headers: headers}) do
    {
      :ok,
      # The direction of the headers sequence is critical!
      %{
        tokens: headers |> get_from("X-VERTICALBOOKINGFETCHCC") |> split(";"),
        errors: headers |> get_from("X-pciBooking-Tokenization-Errors") |> split(";;"),
        warnings: headers |> get_from("X-pciBooking-Tokenization-Warnings") |> split(";;")
      }
    }
  end

  def parse_headers(meta) do
    errors = Map.get(meta, :errors) || []

    {:error,
     Map.merge(meta, %{success: false, errors: ["Meta not content any headers" | errors]})}
  end

  def convert_token_headers(%{tokens: [], errors: [], warnings: []}) do
    {:ok, []}
  end

  def convert_token_headers(%{tokens: tokens, errors: [], warnings: []}) do
    {:ok, Enum.map(tokens, &%{tokens: &1})}
  end

  def convert_token_headers(%{tokens: tokens, errors: [], warnings: warnings}) do
    tokens
    |> list_to_indexed_map(:tokens)
    |> inject_same_length_list(:warnings, warnings)
  end

  def convert_token_headers(%{tokens: tokens, errors: errors, warnings: warnings}) do
    with {map, [], _} <-
           Enum.reduce(errors, {%{}, tokens, 0}, fn error, {map, reduced_tokens, count} ->
             with "" <- error, [head | tail] <- reduced_tokens do
               {Map.put(map, count + 1, %{tokens: head}), tail, count + 1}
             else
               [] -> {map, reduced_tokens, count}
               error -> {Map.put(map, count + 1, %{errors: error}), reduced_tokens, count + 1}
             end
           end) do
      inject_same_length_list(map, :warnings, warnings)
    else
      {_, _, _} -> {:error, :non_consistent_errors_list}
    end
  end

  def rename_keys([]), do: []

  def rename_keys(pci) do
    Enum.map(pci, fn el ->
      %{}
      |> add_key_if_old_key_exists(el, :tokens, :token)
      |> add_key_if_old_key_exists(el, :warnings, :warning)
      |> add_key_if_old_key_exists(el, :errors, :error)
    end)
  end

  defp add_key_if_old_key_exists( acc, pci, old_key, new_key) do
    pci
    |> Map.get(old_key)
    |> case do
      nil -> acc
      token -> Map.put(acc, new_key, token)
    end
  end

  defp inject_same_length_list(map, _inject_key, []) do
    {:ok, Enum.map(map, fn {_key, value} -> value end)}
  end

  defp inject_same_length_list(map, inject_key, list) do
    with {map, []} <-
           Enum.reduce_while(map, {%{}, list}, fn {key, value}, acc ->
             with {acc, [head | tail]} <- acc do
               value = Map.put(value, inject_key, head)
               {:cont, {Map.put(acc, key, value), tail}}
             else
               _ -> {:halt, {:error, :"non_consistent_#{inject_key}_list"}}
             end
           end) do
      {:ok, Enum.map(map, fn {_key, value} -> value end)}
    end
  end

  defp split(nil, _delimiter), do: []
  defp split(header, delimiter), do: String.split(header, delimiter)

  defp list_to_indexed_map(list, key, init \\ {%{}, 0}) do
    {map, _} =
      Enum.reduce(list, init, fn el, {map, count} ->
        {Map.put(map, count + 1, %{key => el}), count + 1}
      end)

    map
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
      {"Cache-Control", "no-cache"}
    ]
  end

  defp get_from(headers, key) do
    with [[_, item] | _] <- Enum.filter(headers, fn [a, _] -> a == key end) do
      item
    else
      _ -> nil
    end
  end
end
