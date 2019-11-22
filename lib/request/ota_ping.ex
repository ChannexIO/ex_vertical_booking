defmodule ExVerticalBooking.Request.OtaPing do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.Document

  @action "OTA_Ping"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}

  @doc """
    Ping message

    This is a simple XML message that could be useful to test if the connection is working correctly. We suggest
  to implement this method first in order to be sure that the SOAP level communication is correct.

  ## Example

    ExVerticalBooking.Request.OtaPing.execute()
  """
  @spec execute(credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(credentials, meta) do
    {{:"ns1:EchoData", nil, ["Echo text"]}, Map.put(meta, :method, @action)}
    |> Document.build(@action, credentials)
    |> Request.send(credentials)
  end
end
