defmodule ExVerticalBooking.Request.Helpers do
  def build_status_application_control(
        %{
          start: sac_start,
          end: sac_end,
          inv_type_code: inv_type_code
        },
        value,
        additional \\ []
      ) do
    map =
      Enum.reduce(
        additional,
        %{Start: sac_start, End: sac_end, InvTypeCode: inv_type_code},
        fn {key, value}, acc ->
          Map.put(acc, key, value)
        end
      )

    {:"ns1:StatusApplicationControl", map, value}
  end

  def build_inv_counts(inv_counts) do
    {:"ns1:InvCounts", nil,
     Enum.map(inv_counts, fn inv_count ->
       {:"ns1:InvCount", %{CountType: inv_count.count_type, Count: inv_count.count}, nil}
     end)}
  end
end
