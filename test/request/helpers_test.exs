defmodule ExVerticalBooking.Request.HelpersTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_request_helpers

  alias ExVerticalBooking.Request.Helpers

  test "build_status_application_control/1" do
    element =
      Helpers.build_status_application_control(
        %{
          start: "2010-11-25",
          end: "2010-11-26",
          inv_type_code: "code"
        },
        nil
      )

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:StatusApplicationControl",
              %{End: "2010-11-26", InvTypeCode: "code", Start: "2010-11-25"}, nil}
  end

  test "build_status_application_control/2" do
    element =
      Helpers.build_status_application_control(
        %{
          start: "2010-11-25",
          end: "2010-11-26",
          inv_type_code: "code"
        },
        nil,
        [{"TestOptions", "Test Value"}]
      )

    element |> XmlBuilder.generate()

    assert element ==
             {:"ns1:StatusApplicationControl",
              %{
                :End => "2010-11-26",
                :InvTypeCode => "code",
                :Start => "2010-11-25",
                "TestOptions" => "Test Value"
              }, nil}
  end
end
