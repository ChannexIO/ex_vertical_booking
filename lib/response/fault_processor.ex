defmodule ExVerticalBooking.Response.FaultProcessor do
  alias ExVerticalBooking.Error

  def create_response(e, meta) do
    e = convert(e)

    {:error, e,
     meta |> Map.put(:success, false) |> Map.put(:errors, [Error.message(e) | meta.errors])}
  end

  def convert(%{faultcode: code, faultstring: string}),
    do: Error.exception({:http_error, {code, string}})

  def convert(%{"faultcode" => code, "faultstring" => string}),
    do: Error.exception({:http_error, {code, string}})

  def convert({:fatal, reason}), do: Error.exception({:fatal, reason})
  def convert({:exit, reason}), do: Error.exception({:exit, reason})
  def convert({:badrpc, {_, reason}}), do: Error.exception(reason)
  def convert({:error, _, %{errors: [reason]}}), do: Error.exception(reason)
  def convert(%ArgumentError{} = reason), do: Error.exception({:argument_error, reason})
  def convert(%FunctionClauseError{} = reason), do: Error.exception({:function_clause, reason})
  def convert(reason), do: Error.exception(reason)
end
