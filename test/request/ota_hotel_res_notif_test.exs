defmodule ExVerticalBooking.Request.OtaHotelResNotifTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_request_ota_hotel_res_notif

  alias ExVerticalBooking.Request.OtaHotelResNotif

  test "build_hotel_res_notif" do
    element =
      OtaHotelResNotif.build_hotel_res_notif(%{
        hotel_reservations: [
          %{
            unique_id: %{
              type: "14",
              id_context: "CrsConfirmNumber",
              id: "287329696/87030894|8953"
            },
            res_global_info: %{
              hotel_reservation_ids: [
                %{
                  res_id_type: "10",
                  res_id_value: "123456ABCD",
                  res_id_source: "PMS",
                  res_id_source_context: "PmsConfirmNumber"
                }
              ]
            }
          }
        ]
      })

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:HotelReservations", nil,
              [
                {:"ns1:HotelReservation", nil,
                 [
                   {:"ns1:UniqueID",
                    %{ID: "287329696/87030894|8953", ID_Context: "CrsConfirmNumber", Type: "14"},
                    nil},
                   {:"ns1:ResGlobalInfo", nil,
                    [
                      {:"ns1:HotelReservationIDs", nil,
                       [
                         {:"ns1:HotelReservationID",
                          %{
                            ResID_Source: "PMS",
                            ResID_SourceContext: "PmsConfirmNumber",
                            ResID_Type: "10",
                            ResID_Value: "123456ABCD"
                          }, nil}
                       ]}
                    ]}
                 ]}
              ]}
  end

  test "build_unique_id/1" do
    element =
      OtaHotelResNotif.build_unique_id(%{
        type: "14",
        id_context: "CrsConfirmNumber",
        id: "287329696/87030894|8953"
      })

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:UniqueID",
              %{ID: "287329696/87030894|8953", ID_Context: "CrsConfirmNumber", Type: "14"}, nil}
  end

  test "build_res_global_info/1" do
    element =
      OtaHotelResNotif.build_res_global_info(%{
        hotel_reservation_ids: [
          %{
            res_id_type: "10",
            res_id_value: "123456ABCD",
            res_id_source: "PMS",
            res_id_source_context: "PmsConfirmNumber"
          }
        ]
      })

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:ResGlobalInfo", nil,
              [
                {:"ns1:HotelReservationIDs", nil,
                 [
                   {:"ns1:HotelReservationID",
                    %{
                      ResID_Source: "PMS",
                      ResID_SourceContext: "PmsConfirmNumber",
                      ResID_Type: "10",
                      ResID_Value: "123456ABCD"
                    }, nil}
                 ]}
              ]}
  end
end
