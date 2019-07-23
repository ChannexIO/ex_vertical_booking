defmodule ExVerticalBooking.Request.OtaHotelBookingRuleNotif do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document, Helpers}

  @action "OTA_HotelBookingRuleNotif"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type t ::
          %{
            hotel_code: String.t(),
            rule_messages: [
              %{
                status_application_control: %{
                  start: String.t(),
                  end: String.t(),
                  inv_type_code: String.t(),
                  rate_plan_code: String.t(),
                  destination_system_codes: [integer]
                },
                booking_rules: [
                  %{
                    lengths_of_stay:
                      [
                        %{
                          time: String.t(),
                          time_unit: String.t(),
                          min_max_message_type: String.t()
                        }
                      ]
                      | nil,
                    restriction_status: %{restriction: String.t(), status: String.t()} | nil
                  }
                ]
              }
            ]
          }

  @doc """
  This method is used to update booking rule.
  """
  @spec execute(t, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _, rule_messages: _} = params, credentials, meta) do
    params
    |> build_hotel_booking_rule_notif()
    |> Document.build(@action, credentials, [{"Target", "Production"}])
    |> Request.send(meta)
  end

  @spec build_hotel_booking_rule_notif(t) :: {atom(), map | nil, list | nil}
  def build_hotel_booking_rule_notif(%{
        hotel_code: hotel_code,
        rule_messages: rule_messages
      }) do
    rule_messages_elements =
      rule_messages
      |> Enum.map(fn %{
                       status_application_control: status_application_control,
                       booking_rules: booking_rules
                     } ->
        {:"ns1:RuleMessage", nil,
         [
           Helpers.build_status_application_control(
             status_application_control,
             [destination_system_codes(status_application_control.destination_system_codes)],
             [
               {:RatePlanCode, status_application_control.rate_plan_code}
             ]
           ),
           build_booking_rules(booking_rules)
         ]}
      end)

    {:"ns1:RuleMessages", %{HotelCode: "#{hotel_code}"}, rule_messages_elements}
  end

  def build_booking_rules(booking_rules) do
    {:"ns1:BookingRules", nil,
     Enum.map(booking_rules, fn booking_rule ->
       {:"ns1:BookingRule", nil, [build_booking_rule(booking_rule)]}
     end)
     |> List.flatten()}
  end

  def build_booking_rule(%{lengths_of_stay: lengths_of_stay}) when not is_nil(lengths_of_stay) do
    build_lengths_of_stay(lengths_of_stay)
  end

  def build_booking_rule(%{restriction_status: restriction_status}) do
    build_restriction_status(restriction_status)
  end

  def build_lengths_of_stay(nil), do: []

  def build_lengths_of_stay(lengths_of_stay) do
    {:"ns1:LengthsOfStay", nil,
     Enum.map(lengths_of_stay, fn %{
                                    min_max_message_type: min_max_message_type,
                                    time: time,
                                    time_unit: time_unit
                                  } ->
       {:"ns1:LengthOfStay",
        %{
          Time: time,
          TimeUnit: time_unit,
          MinMaxMessageType: min_max_message_type
        }, nil}
     end)}
  end

  def build_restriction_status(nil), do: []

  def build_restriction_status(%{restriction: restriction, status: status}) do
    {:"ns1:RestrictionStatus",
     %{
       Rerstriction: restriction,
       Status: status
     }, nil}
  end

  def destination_system_codes(destination_system_codes) do
    {:"ns1:DestinationSystemCodes", nil,
     Enum.map(destination_system_codes, fn destination_system_code ->
       {:"ns1:DestinationSystemCode", nil, destination_system_code}
     end)}
  end
end
