defmodule ExVerticalBooking.Request.OtaRead do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document}
  @action "OTA_Read"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}

  @doc """
  This method is used to update availability.
  """
  @spec execute(%{hotel_code: String.t()}, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _} = params, credentials, meta) do
    params
    |> build_read()
    |> Document.build(@action, credentials)
    |> Request.send(meta, credentials)
  end

  @spec build_read(%{hotel_code: String.t()}) :: {atom(), map | nil, list | nil}
  def build_read(%{hotel_code: hotel_code}) do
    {:"ns1:ReadRequests", nil, [{:"ns1:HotelReadRequest", %{HotelCode: "#{hotel_code}"}, nil}]}
  end
end
