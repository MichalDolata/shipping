defmodule Shipping.Tracker do
  alias Shipping.Driver.Events.LoadPickedUp
  alias Shipping.Driver.Events.LoadDelivered

  alias Shipping.Tracker

  def handle_load_picked_up(%LoadPickedUp{load_id: load_id,
    driver_id: driver_id} = event) do
    load = Tracker.LoadStorage.fetch_by_id(load_id)

    Tracker.DriverPositionStorage.update_position(driver_id, load_id)
  end
end