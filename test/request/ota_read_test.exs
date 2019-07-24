defmodule ExVerticalBooking.Request.OtaReadTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_request_ota_read

  alias ExVerticalBooking.Request.OtaRead

  @hotel_code "2e097d85-9eec-433a-9f0a-dd4f1622501f"
  @meta %{
    request: nil,
    response: nil,
    method: nil,
    started_at: DateTime.utc_now(),
    finished_at: nil,
    success: true,
    errors: []
  }
  test "build_hotel_rate_amount_notif" do
    {element, _meta} = OtaRead.build_read(%{hotel_code: @hotel_code}, @meta)

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:ReadRequests", nil,
              [
                {:"ns1:HotelReadRequest", %{HotelCode: "2e097d85-9eec-433a-9f0a-dd4f1622501f"},
                 nil}
              ]}
  end
end
