defmodule ExVerticalBooking.Request.Document do
  @moduledoc """
  Headers generator by soap action and custom headers.
  """
  alias ExVerticalBooking.Response.FaultProcessor

  @definitions %{
    "xmlns:SOAP-ENV" => "http://schemas.xmlsoap.org/soap/envelope/",
    "xmlns:ns1" => "http://www.opentravel.org/OTA/2003/05",
    "xmlns:ns2" =>
      "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd",
    "xmlns:ns3" => "http://schemas.xmlsoap.org/ws/2004/08/addressing"
  }

  def build(payload, action, credentials, addition \\ [])
  def build({:error, payload, meta}, _, _, _), do: {:error, payload, meta}

  def build({payload_element, meta}, action, credentials, addition) do
    try do
      {{action, credentials, build_body(addition, action, payload_element)} |> generate(), meta}
    rescue
      e in ArgumentError -> FaultProcessor.create_response(e, meta)
      e in FunctionClauseError -> FaultProcessor.create_response(e, meta)
    end
  end

  def build_operation(addition) do
    Enum.reduce(
      addition,
      %{TimeStamp: DateTime.utc_now() |> DateTime.to_iso8601(), Version: "1"},
      fn {name, value}, acc -> Map.put(acc, name, value) end
    )
  end

  def build_operation_element(addition, action, payload_element) do
    {:"ns1:#{action}RQ", build_operation(addition), [payload_element]}
  end

  def build_body(addition, action, payload_element) do
    {:"SOAP-ENV:Body", nil, [build_operation_element(addition, action, payload_element)]}
  end

  def generate({action, credentials, body}) do
    XmlBuilder.generate(:xml_decl, encoding: "UTF-8") <>
      XmlBuilder.generate(
        {:"SOAP-ENV:Envelope", @definitions, [header(action, credentials), body]},
        format: :none
      )
  end

  #  def check_generation()

  def header(action, credentials) do
    auth_element =
      XmlBuilder.element(:UsernameToken, nil,
        Username: credentials.user,
        Password: credentials.password
      )

    security_element =
      XmlBuilder.element(:"ns2:Security", %{"SOAP-ENV:mustUnderstand" => "1"}, [auth_element])

    message_id_element = XmlBuilder.element(:"ns3:MessageID", "uuid:#{UUID.uuid4()}")

    to_element = XmlBuilder.element(:"ns3:To", credentials.endpoint)
    action_element = XmlBuilder.element(:"ns3:Action", "#{action}RQ")

    address_element =
      XmlBuilder.element(
        :"ns3:Address",
        "http://schemas.xmlsoap.org/ws/2004/12/addressing/role/anonymous"
      )

    from_element = XmlBuilder.element(:"ns3:From", nil, [address_element])

    XmlBuilder.element(:"SOAP-ENV:Header", [
      security_element,
      message_id_element,
      to_element,
      action_element,
      from_element
    ])
  end
end
