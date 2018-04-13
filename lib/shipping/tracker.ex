defmodule Shipping.Tracker do
  alias Shipping.Driver.Events.LoadPickedUp
  alias Shipping.Driver.Events.LoadDelivered

  alias Shipping.Tracker
  alias Shipping.Tracker.Position

  def handle_load_picked_up(%LoadPickedUp{load_id: load_id,
    driver_id: driver_id} = event) do
    Tracker.LoadStorage.assign_driver(load_id, driver_id)
    load = Tracker.LoadStorage.fetch_by_id(load_id)

    position = %Position{
      driver_id: driver_id,
      lat: load.lat,
      lng: load.lng,
      delivered: false
    }

    Tracker.DriverPositionStorage.update_position(driver_id, position)
  end

  def handle_load_delivered(%LoadDelivered{load_id: load_id}) do
    %Tracker.Load{driver_id: driver_id} = Tracker.LoadStorage.fetch_by_id(load_id)

    Tracker.DriverPositionStorage.set_as_delivered(driver_id)
  end
end