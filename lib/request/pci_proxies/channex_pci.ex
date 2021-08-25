defmodule ExVerticalBooking.Request.PCIProxies.ChannexPCI do
  alias ExVerticalBooking.Request

  @pci_url "https://pci.channex.io/api/v1/capture"
  @pci_profile "vertical_booking"

  @spec proxy_send({String.t(), map()}, map()) :: {:ok, map(), map()} | {:error, map(), map()}
  def proxy_send({document, %{success: true} = meta}, %{endpoint: endpoint, api_key: api_key}) do
    with url <- get_url(endpoint, api_key),
         {:ok, response, meta} <- Request.send({document, meta}, %{endpoint: url}, []) do
      enriched_meta =
        with {:ok, headers} <- parse_headers(meta),
             {:ok, pci} <- convert_token_headers(headers) do
          Map.put(meta, :pci, pci)
        else
          {:error, error} ->
            meta
            |> Map.put(:success, false)
            |> Map.update(:errors, error, &[error | &1])
        end

      {:ok, response, enriched_meta}
    end
  end

  def proxy_send(payload, credentials) do
    Request.send(payload, credentials)
  end

  defp get_url(endpoint, api_key) do
    "#{@pci_url}?apikey=#{api_key}&method=post&profile=#{@pci_profile}&url=#{endpoint}&savecvv=true"
  end

  def parse_headers(%{headers: headers}) do
    {
      :ok,
      # The direction of the headers sequence is critical!
      %{
        tokens: headers |> get_from("x-pci-channex-tokens") |> split(","),
        errors: headers |> get_from("x-pci-channex-errors") |> split(","),
        warnings: headers |> get_from("x-pci-channex-warnings") |> split(",")
      }
    }
  end

  def parse_headers(_meta), do: {:error, "Meta not contains any headers"}

  def convert_token_headers(meta) do
    tokens = Map.get(meta, :tokens) || []
    errors = Map.get(meta, :errors) || List.duplicate("", length(tokens))
    warnings = Map.get(meta, :warnings) || List.duplicate("", length(tokens))

    combine_headers([], tokens, errors, warnings)
  end

  defp combine_headers(result, [], [], []), do: {:ok, result}

  defp combine_headers(result, [token | tokens], [error | errors], [warning | warnings]) do
    result
    |> result_headers_update(token, error, warning)
    |> combine_headers(tokens, errors, warnings)
  end

  defp combine_headers(_result, _tokens, _errors, []) do
    {:error, "Headers contains non consistent warnings list"}
  end

  defp combine_headers(_result, [], [], _warnings) do
    {:error, "Headers contains non consistent warnings list"}
  end

  defp combine_headers(_result, [], _errors, _warnings) do
    {:error, "Headers contains non consistent errors list"}
  end

  defp combine_headers(_result, _tokens, [], _warnings) do
    {:error, "Headers contains non consistent errors list"}
  end

  defp result_headers_update(result, token, error, warning) do
    insertion =
      %{}
      |> insert_header(:token, token)
      |> insert_header(:error, error)
      |> insert_header(:warning, warning)
      |> List.wrap()

    result ++ insertion
  end

  defp insert_header(map, _, ""), do: map
  defp insert_header(map, name, header), do: Map.put(map, name, header)

  defp split(nil, _delimiter), do: nil
  defp split(header, delimiter), do: header |> String.split(delimiter) |> Enum.map(&String.trim/1)

  defp get_from(headers, key), do: Enum.find_value(headers, &compare_keys(&1, key))

  defp compare_keys([header_key, header_value], key) do
    if String.downcase(header_key) == String.downcase(key), do: header_value
  end
end
