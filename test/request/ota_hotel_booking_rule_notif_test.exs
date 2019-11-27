defmodule ExVerticalBooking.Request.OtaHotelBookingRuleNotifTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_request_ota_hotel_booking_rule_notif

  alias ExVerticalBooking.Request.OtaHotelBookingRuleNotif

  @hotel_code "2e097d85-9eec-433a-9f0a-dd4f1622501f"

  @meta %{
    request: nil,
    response: nil,
    method: "OTA_action",
    started_at: DateTime.utc_now(),
    finished_at: nil,
    success: true,
    errors: []
  }

  test "build_hotel_booking_rule_notif/2" do
    {element, _meta} =
      OtaHotelBookingRuleNotif.build_hotel_booking_rule_notif(
        %{
          hotel_code: @hotel_code,
          rule_messages: [
            %{
              status_application_control: %{
                start: "2010-06-19",
                end: "2010-06-20",
                inv_type_code: "DBL",
                rate_plan_code: "BAR",
                destination_system_codes: [1, 2, 3]
              },
              booking_rules: [
                %{
                  lengths_of_stay: [
                    %{time: "2", time_unit: "Day", min_max_message_type: "SetMinLOS"}
                  ],
                  restriction_status: nil
                },
                %{
                  lengths_of_stay: nil,
                  restriction_status: %{restriction: "Master", status: "Close"}
                },
                %{
                  lengths_of_stay: nil,
                  restriction_status: %{restriction: "Arrival", status: "Open"}
                },
                %{
                  lengths_of_stay: nil,
                  restriction_status: %{restriction: "Departure", status: "Close"}
                }
              ]
            }
          ]
        },
        @meta
      )

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:RuleMessages", %{HotelCode: "2e097d85-9eec-433a-9f0a-dd4f1622501f"},
              [
                {:"ns1:RuleMessage", nil,
                 [
                   {:"ns1:StatusApplicationControl",
                    %{
                      End: "2010-06-20",
                      InvTypeCode: "DBL",
                      RatePlanCode: "BAR",
                      Start: "2010-06-19"
                    },
                    [
                      {:"ns1:DestinationSystemCodes", nil,
                       [
                         {:"ns1:DestinationSystemCode", nil, 1},
                         {:"ns1:DestinationSystemCode", nil, 2},
                         {:"ns1:DestinationSystemCode", nil, 3}
                       ]}
                    ]},
                   {:"ns1:BookingRules", nil,
                    [
                      {:"ns1:BookingRule", nil,
                       [
                         {:"ns1:LengthsOfStay", nil,
                          [
                            {:"ns1:LengthOfStay",
                             %{MinMaxMessageType: "SetMinLOS", Time: "2", TimeUnit: "Day"}, nil}
                          ]}
                       ]},
                      {:"ns1:BookingRule", nil,
                       [
                         {:"ns1:RestrictionStatus", %{Rerstriction: "Master", Status: "Close"},
                          nil}
                       ]},
                      {:"ns1:BookingRule", nil,
                       [
                         {:"ns1:RestrictionStatus", %{Rerstriction: "Arrival", Status: "Open"},
                          nil}
                       ]},
                      {:"ns1:BookingRule", nil,
                       [
                         {:"ns1:RestrictionStatus", %{Rerstriction: "Departure", Status: "Close"},
                          nil}
                       ]}
                    ]}
                 ]}
              ]}
  end

  test "build_hotel_booking_rule_notif_fail" do
    assert {:error, _, %{success: false, errors: [:empty_payload]}} =
             OtaHotelBookingRuleNotif.build_hotel_booking_rule_notif(
               %{hotel_code: @hotel_code, rule_messages: []},
               @meta
             )
  end

  test "build_booking_rules/1" do
    element =
      OtaHotelBookingRuleNotif.build_booking_rules([
        %{
          lengths_of_stay: [
            %{time: "2", time_unit: "Day", min_max_message_type: "SetMinLOS"}
          ],
          restriction_status: nil
        },
        %{
          lengths_of_stay: nil,
          restriction_status: %{restriction: "Master", status: "Close"}
        },
        %{
          lengths_of_stay: nil,
          restriction_status: %{restriction: "Arrival", status: "Open"}
        },
        %{
          lengths_of_stay: nil,
          restriction_status: %{restriction: "Departure", status: "Close"}
        }
      ])

    element |> XmlBuilder.generate()
  end

  test "build_booking_rule/1" do
    element =
      OtaHotelBookingRuleNotif.build_booking_rule(%{
        lengths_of_stay: [
          %{time: "2", time_unit: "Day", min_max_message_type: "SetMinLOS"}
        ],
        restriction_status: nil
      })

    element |> XmlBuilder.generate()
  end

  test "build_lengths_of_stay/1" do
    element =
      OtaHotelBookingRuleNotif.build_lengths_of_stay([
        %{
          time: "2",
          time_unit: "Day",
          min_max_message_type: "SetMinLOS"
        }
      ])

    element |> XmlBuilder.generate()
  end

  test "build_restriction_status/1" do
    element =
      OtaHotelBookingRuleNotif.build_restriction_status(%{
        restriction: "Departure",
        status: "Close"
      })

    element |> XmlBuilder.generate()
  end

  test "destination_system_codes/1" do
    element = OtaHotelBookingRuleNotif.destination_system_codes([1, 2, 3])

    element |> XmlBuilder.generate()
  end
end
