defmodule Shipping.Tracker.LoadStorage do
  use Agent

  alias Shipping.Shipper.Events.LoadCreated

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def store_load(%LoadCreated{} = event) do
    load = %{
      uuid: event.uuid,
      shipper_id: event.shipper_id,
      lat: event.lat,
      lng: event.lng
    }

    Agent.update(__MODULE__, fn state -> 
      state |> Map.put(event.uuid, load)
    end)
  end

  def fetch_by_id(load_uuid) do
    Agent.get(__MODULE__, fn state ->
      state |> Map.fetch!(load_uuid)
    end)
  end
end