defmodule ExVerticalBooking.Response.FaultProcessor do
  alias ExVerticalBooking.Error

  def convert(%{faultcode: code, faultstring: _string}), do: Error.exception(code)
  def convert(%{"faultcode" => code, "faultstring" => _string}), do: Error.exception(code)
  def convert({:fatal, _reason}), do: Error.exception(:xml_parsing_error)
end
