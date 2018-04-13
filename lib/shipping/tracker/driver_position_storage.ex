defmodule Shipping.Tracker.DriverPositionStorage do
  use Agent

  alias Shipping.Tracker.Position

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def update_position(driver_id, %Position{} = position) do
    Agent.update(__MODULE__, fn state ->
      state |> Map.put(driver_id, position)
    end)
  end

  def get_position(driver_id) do
    Agent.get(__MODULE__, fn state ->
      state |> Map.fetch!(driver_id)
    end)
  end

  def set_as_delivered(driver_id) do
    Agent.update(__MODULE__, fn state ->
      put_in(state, [driver_id, Access.key!(:delivered)], true)
    end)
  end
end