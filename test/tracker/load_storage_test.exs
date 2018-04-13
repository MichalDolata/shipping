defmodule Shipping.Tracker.LoadStorageTest do
  use ExUnit.Case, async: false

  alias Shipping.Tracker.LoadStorage
  alias Shipping.Tracker.Load

  @event %Shipping.Shipper.Events.LoadCreated{
    car_type: :small,
    lat: 10.0,
    lng: 10.0,
    number_of_trips: 5,
    shipper_id: "shipper_id",
    start_date_millis: 1000,
    timestamp: 1_515_403_696_862,
    uuid: "uuid"
  }

  test "stores the load after receiving the event" do
    LoadStorage.store_load(@event)

    assert %Load{uuid: uuid} = LoadStorage.fetch_by_id(@event.uuid)
    assert uuid = @event.uuid
  end

  test "stores driver id after assign" do
    LoadStorage.store_load(@event)
    LoadStorage.assign_driver(@event.uuid, "driver_id")

    assert %Load{driver_id: "driver_id"} = LoadStorage.fetch_by_id(@event.uuid)
  end
end
