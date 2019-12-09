defmodule ExVerticalBooking.Request.OtaRead do
  require Logger
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request.PCIProxies.PCIBooking
  alias ExVerticalBooking.Request.{Document}
  @action "OTA_Read"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}

  @doc """
  This method is used to update availability.
  """
  @spec execute(%{hotel_code: String.t()}, credentials, Meta.t()) ::
          {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: hotel_code} = params, credentials, meta) do
    Logger.log(:info, "VerticalBooking ReadRequest.execute for #{hotel_code}")

    params
    |> build_read(Map.put(meta, :method, @action))
    |> Document.build(@action, credentials)
    |> PCIBooking.proxy_send(credentials)
  end

  @spec build_read(%{hotel_code: String.t()}, Meta.t()) ::
          {{atom(), map | nil, list | nil}, Meta.t()}
  def build_read(%{hotel_code: hotel_code}, meta) do
    {{:"ns1:ReadRequests", nil, [{:"ns1:HotelReadRequest", %{HotelCode: "#{hotel_code}"}, nil}]},
     meta}
  end
end
