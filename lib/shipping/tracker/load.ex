defmodule Shipping.Tracker.Load do
  @fields [
    :uuid,
    :shipper_id,
    :number_of_trips,
    :car_type,
    :start_date_millis,
    :lat,
    :lng,
    :driver_id
  ]

  @enforce_keys @fields
  defstruct @fields
end