defmodule Shipping.Tracker.LoadStorage do
  use Agent

  alias Shipping.Shipper.Events.LoadCreated

  alias Shipping.Tracker.Load

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def store_load(%LoadCreated{} = event) do
    load = %Load{
      uuid: event.uuid,
      shipper_id: event.shipper_id,
      number_of_trips: event.number_of_trips,
      car_type: event.car_type,
      start_date_millis: event.start_date_millis,
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