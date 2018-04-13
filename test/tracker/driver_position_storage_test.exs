defmodule Shipping.Tracker.DriverPositionStorageTest do
  use ExUnit.Case, async: false

  alias Shipping.Tracker.DriverPositionStorage
  alias Shipping.Tracker.Position

  @position %Shipping.Tracker.Position{
    driver_id: "driver_id",
    lat: 10.0,
    lng: 10.0,
    delivered: false
  }

  test "stores the position after receiving load id and driver id" do
    DriverPositionStorage.update_position("driver_id", @position)

    assert %Position{} = DriverPositionStorage.get_position("driver_id")
  end
end
