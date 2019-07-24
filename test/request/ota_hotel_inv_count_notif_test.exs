defmodule ExVerticalBooking.Request.OtaHotelInvCountNotifTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_request_ota_hotel_inv_count_notif

  alias ExVerticalBooking.Request.OtaHotelInvCountNotif

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
  test "build_hotel_inv_count_notif" do
    {element, _meta} =
      OtaHotelInvCountNotif.build_hotel_inv_count_notif(
        %{
          hotel_code: @hotel_code,
          inventories: [
            %{
              status_application_control: %{
                start: "2010-11-25",
                end: "2010-11-26",
                inv_type_code: "code"
              },
              inv_counts: [%{count_type: 1, count: 10}]
            }
          ]
        },
        @meta
      )

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:Inventories", %{HotelCode: @hotel_code},
              [
                {:"ns1:Inventory", nil,
                 [
                   {:"ns1:StatusApplicationControl",
                    %{End: "2010-11-26", InvTypeCode: "code", Start: "2010-11-25"}, nil},
                   {:"ns1:InvCounts", nil, [{:"ns1:InvCount", %{Count: 10, CountType: 1}, nil}]}
                 ]}
              ]}
  end

  test "build_hotel_inv_count_notif_fail" do
    assert {:error, _, %{success: false, errors: [:empty_payload]}} =
             OtaHotelInvCountNotif.build_hotel_inv_count_notif(
               %{hotel_code: @hotel_code, inventories: []},
               @meta
             )
  end
end
