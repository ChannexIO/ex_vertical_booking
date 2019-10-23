defmodule ExVerticalBooking.Request.PCIProxies.PCIBooking do
  alias ExVerticalBooking.Request
  @api_endpoint "https://service.pcibooking.net/api"

  @spec proxy_send({String.t(), map()}, map()) :: {:ok, map(), map()} | {:error, map(), map()}
  def proxy_send({document, %{success: true} = meta}, %{endpoint: endpoint, api_key: api_key}) do
    with {:ok, temp_session} <- start_temporary_session(api_key),
         url <- get_tokenized_booking_url(endpoint, temp_session),
         {:ok, response, meta} <- send_request(url, {document, meta}, api_key),
         %{headers: headers} <- meta do
      {:ok, response,
       Map.put(meta, :pci, %{
         tokens: headers |> get_from("X-VERTICALBOOKINGFETCHCC") |> String.split(";"),
         errors: get_from(headers, "X-pciBooking-Tokenization-Errors"),
         warnings: get_from(headers, "X-pciBooking-Tokenization-Warnings")
       })}
    end
  end

  def proxy_send(payload, credentials) do
    Request.send(payload, credentials)
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
