defmodule ExVerticalBooking.Request.DocumentTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_headers

  alias ExVerticalBooking.Request.Document

  @endpoint "fake_endpoint"
  @username "USERNAME"
  @password "PASSWORD"
  @hotel_code "2e097d85-9eec-433a-9f0a-dd4f1622501f"
  @credentials %{
    user: @username,
    password: @password,
    endpoint: @endpoint,
    hotel_code: @hotel_code
  }
  @meta %{
    request: nil,
    response: nil,
    method: nil,
    started_at: DateTime.utc_now(),
    finished_at: nil,
    success: true,
    errors: []
  }
  test "header/2" do
    headers = Document.header("TEST_action", @credentials)

    assert {:"SOAP-ENV:Header", nil,
            [
              {:"ns2:Security", %{"SOAP-ENV:mustUnderstand" => "1"},
               [
                 {:UsernameToken, nil,
                  [
                    {:Username, nil, @username},
                    {:Password, nil, @password}
                  ]}
               ]},
              {:"ns3:MessageID", nil, _},
              {:"ns3:To", nil, @endpoint},
              {:"ns3:Action", nil, "TEST_actionRQ"},
              {:"ns3:From", nil,
               [
                 {:"ns3:Address", nil,
                  "http://schemas.xmlsoap.org/ws/2004/12/addressing/role/anonymous"}
               ]}
            ]} = headers
  end

  test "build/3" do
    {document, _meta} =
      Document.build(
        {{:tag, %{element_1: 1, element_2: "two"}, ["Value_1", "Value_2"]}, @meta},
        "TEST_Action",
        @credentials
      )

    assert document =~ ~s(<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.opentravel.org/OTA/2003/05" xmlns:ns2="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:ns3="http://schemas.xmlsoap.org/ws/2004/08/addressing">
  <SOAP-ENV:Header>
    <ns2:Security SOAP-ENV:mustUnderstand="1">
      <UsernameToken>
        <Username>#{@username}</Username>
        <Password>#{@password}</Password>
      </UsernameToken>
    </ns2:Security>
    <ns3:MessageID>uuid:)

    assert document =~ ~s(</ns3:MessageID>
    <ns3:To>#{@endpoint}</ns3:To>
    <ns3:Action>TEST_ActionRQ</ns3:Action>
    <ns3:From>
      <ns3:Address>http://schemas.xmlsoap.org/ws/2004/12/addressing/role/anonymous</ns3:Address>
    </ns3:From>
  </SOAP-ENV:Header>
  <SOAP-ENV:Body>
    <ns1:TEST_ActionRQ TimeStamp=)

    assert document =~ ~s(Z" Version="1">
      <tag element_1="1" element_2="two">
        Value_1
        Value_2
      </tag>
    </ns1:TEST_ActionRQ>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>)
  end
end
