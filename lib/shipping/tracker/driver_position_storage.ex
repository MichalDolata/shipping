defmodule Shipping.Tracker.DriverPositionStorage do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def update_position(driver_id, %{lat: lat, lng: lng, delivered: delivered}) do
    Agent.update(__MODULE__, fn state ->
      state |> Map.put(driver_id, %{lat: lat, lng: lng, delivered: delivered})
    end)
  end

  def get_posistion(driver_id) do
    Agent.get(__MODULE__, fn state ->
      state |> Map.fetch!(driver_id)
    end)
  end
end