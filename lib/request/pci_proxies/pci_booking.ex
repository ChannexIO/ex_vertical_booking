defmodule ExVerticalBooking.Request.PCIProxies.PCIBooking do
  alias ExVerticalBooking.Request
  @api_endpoint "https://service.pcibooking.net/api"
  @card_types %{
    1 => :visa,
    2 => :mastercard,
    4 => :discover,
    8 => :amex,
    16 => :en_route,
    32 => :jcb,
    64 => :diners,
    256 => :maestro
  }

  @spec proxy_send({String.t(), map()}, map()) :: {:ok, map(), map()} | {:error, map(), map()}
  def proxy_send({document, %{success: true} = meta}, %{endpoint: endpoint, api_key: api_key}) do
    url = get_tokenized_booking_url(endpoint)
    with {:ok, response, meta} <-
           Request.send({document, meta}, %{endpoint: "#{@api_endpoint}#{url}"}, headers(api_key)),
         %{headers: headers} <- meta do
      {:ok, response,
       Map.put(meta, :pci, %{
         token: get_from(headers, "X-VERTICALBOOKINGFETCHCC"),
         errors: get_from(headers, "X-pciBooking-Tokenization-Errors"),
         warnings: get_from(headers, "X-pciBooking-Tokenization-Warnings")
       })}
    end
  end

  def proxy_send(payload, credentials) do
    Request.send(payload, credentials)
  end

  defp get_tokenized_booking_url(endpoint) do
    get_url("/payments/paycard/capture",
      httpMethod: "POST",
      profileName: "VerticalBooking",
      targetURI: endpoint,
      saveCVV: true
    )
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
end
