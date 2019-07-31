defmodule ExVerticalBooking.Error do
  defexception [:reason]
  @type t :: %__MODULE__{reason: any}

  @impl true
  def exception(code), do: %__MODULE__{reason: reason_for(code)}

  @impl true
  def message(%__MODULE__{reason: reason}), do: humanize_error(reason)

  @doc """
  Convert API Error code to reason atom
  """
  @spec reason_for(neg_integer()) :: atom()

  def reason_for(:xml_parsing_error), do: :xml_parsing_error
  def reason_for(:invalid_endpoint), do: :invalid_endpoint
  def reason_for(:empty_payload), do: :empty_payload
  def reason_for("15"), do: :date_in_the_past_or_not_alowed
  def reason_for("321"), do: :required_field_missing
  def reason_for("402"), do: :invalid_room_type
  def reason_for("404"), do: :invalid_date_range
  def reason_for("497"), do: :invalid_authorisation
  def reason_for({:function_clause, reason}), do: {:function_clause, reason}
  def reason_for({:argument_error, reason}), do: {:argument_error, reason}
  def reason_for(_), do: :undefined_error
  def reason_for("SOAP-ENV:" <> _, _reason), do: :invalid_api_request
  def reason_for(_, _), do: :undefined_error

  @doc """
  Convert reason atom to human readable string
  """
  @spec humanize_error(atom) :: String.t()
  def humanize_error(:xml_parsing_error),
    do: "XML parsing error"

  def humanize_error(:invalid_endpoint),
    do: "Invalid endpoint"

  def humanize_error(:empty_payload),
    do: "Empty payload"

  def humanize_error(:date_in_the_past_or_not_alowed),
    do: "Invalid date: updates in the past are not allowed"

  def humanize_error(:required_field_missing),
    do: "Required field missing"

  def humanize_error(:invalid_date_range),
    do: "Invalid start/end date combination"

  def humanize_error(:invalid_room_type),
    do: "Invalid room type"

  def humanize_error(:invalid_authorisation),
    do: "Authorization error"

  def humanize_error(:invalid_api_request),
    do: "Invalid builded structure of API request"

  def humanize_error(:undefined_error),
    do: "Undefined error"

  def humanize_error(reason) when is_binary(reason),
    do: reason

  def humanize_error({:function_clause, reason}), do: "Function clause error #{reason}}"
  def humanize_error({:argument_error, reason}), do: "Argument error #{reason}}"
end
