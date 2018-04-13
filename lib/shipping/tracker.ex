defmodule Shipping.Tracker do
  alias Shipping.Driver.Events.LoadPickedUp
  alias Shipping.Driver.Events.LoadDelivered
  alias Shipping.Tracker.Events.DriverPositionChanged

  alias Shipping.Tracker
  alias Shipping.Tracker.Position

  alias Shipping.PubSub

  def handle_load_picked_up(%LoadPickedUp{load_id: load_id,
    driver_id: driver_id}) do
    Tracker.LoadStorage.assign_driver(load_id, driver_id)
    load = Tracker.LoadStorage.fetch_by_id(load_id)

    position = %Position{
      driver_id: driver_id,
      lat: load.lat,
      lng: load.lng,
      delivered: false
    }

    Tracker.DriverPositionStorage.update_position(driver_id, position)
    
    position_changed = %DriverPositionChanged{
      driver_id: driver_id,
      lat: load.lat,
      lng: load.lng,
      delivered: false
    }

    PubSub.publish("driver_position_changed", position_changed)
  end

  def handle_load_delivered(%LoadDelivered{load_id: load_id}) do
    %Tracker.Load{driver_id: driver_id} = load = Tracker.LoadStorage.fetch_by_id(load_id)

    Tracker.DriverPositionStorage.set_as_delivered(driver_id)

    position_changed = %DriverPositionChanged{
      driver_id: driver_id,
      lat: load.lat,
      lng: load.lng,
      delivered: true
    }
    
    PubSub.publish("driver_position_changed", position_changed)
  end

  def get_all_drivers_positions() do
    Tracker.DriverPositionStorage.get_all_positions()
  end

  def get_driver_position(driver_id) do
    Tracker.DriverPositionStorage.get_position(driver_id)
  end

  def change_driver_position(driver_id, %Position{} = position) do
    Tracker.DriverPositionStorage.update_position(driver_id, position)
  end
end