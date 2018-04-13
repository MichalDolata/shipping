defmodule Shipping.Tracker.Position do
  @fields [
    :driver_id,
    :lat,
    :lng,
    :delivered
  ]

  @enforce_keys @fields
  defstruct @fields
end