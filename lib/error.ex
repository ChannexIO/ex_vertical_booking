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

  def reason_for(:invalid_endpoint), do: :invalid_endpoint
  def reason_for(:empty_payload), do: :empty_payload
  def reason_for("15"), do: :date_in_the_past_or_not_alowed
  def reason_for("321"), do: :required_field_missing
  def reason_for("402"), do: :invalid_room_type
  def reason_for("404"), do: :invalid_date_range
  def reason_for("497"), do: :invalid_authorisation
  def reason_for({:http_error, {"15", string}}), do: {:date_in_the_past_or_not_alowed, string}
  def reason_for({:http_error, {"321", string}}), do: {:required_field_missing, string}
  def reason_for({:http_error, {"402", string}}), do: {:invalid_room_type, string}
  def reason_for({:http_error, {"404", string}}), do: {:invalid_date_range, string}
  def reason_for({:http_error, {"497", string}}), do: {:invalid_authorization, string}
  def reason_for({:http_error, {code, string}}), do: {:http_error, {code, string}}
  def reason_for({:function_clause, reason}), do: {:function_clause, reason}
  def reason_for({:argument_error, reason}), do: {:argument_error, reason}
  def reason_for({:fatal, reason}), do: {:catch_error, reason}
  def reason_for({:exit, reason}), do: {:catch_error, reason}
  def reason_for(e), do: {:undefined_error, e}
  def reason_for("SOAP-ENV:" <> _, reason), do: {:invalid_api_request, reason}
  def reason_for(arg1, arg2), do: {:undefined_error, {arg1, arg2}}

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

  def humanize_error(:undefined_error),
    do: "Undefined error"

  def humanize_error(reason) when is_binary(reason),
    do: reason

  def humanize_error({:invalid_api_request, reason}),
    do: "Invalid builded structure of API request: #{reason}"

  def humanize_error({:function_clause, reason}), do: "Function clause error: #{reason}}"
  def humanize_error({:argument_error, reason}), do: "Argument error: #{reason}}"
  def humanize_error({:catch_error, reason}), do: "Catch error: #{reason}}"

  def humanize_error({:date_in_the_past_or_not_alowed, reason}),
    do: "Invalid date: updates in the past are not allowed: #{reason}}"

  def humanize_error({:required_field_missing, reason}),
    do: "Required field missing error: #{reason}}"

  def humanize_error({:invalid_room_type, reason}), do: "Invalid room type error: #{reason}}"
  def humanize_error({:invalid_date_range, reason}), do: "Invalid date range error: #{reason}}"

  def humanize_error({:invalid_authorization, reason}),
    do: "Invalid authorization error: #{reason}}"

  def humanize_error({:undefined_error, reason}), do: "Undefined error: #{reason}}"
  def humanize_error(reason), do: "Undefined error: #{reason}}"
end
