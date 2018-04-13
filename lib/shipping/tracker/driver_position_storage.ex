defmodule Shipping.Tracker.DriverPositionStorage do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end
end