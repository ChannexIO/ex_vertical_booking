defmodule ExVerticalBooking.Response.OtaPing do
  alias ExVerticalBooking.Response.Converter

  @list_nodes []

  def list_nodes, do: @list_nodes
  def convert(struct), do: Converter.convert(struct, @list_nodes)
end
