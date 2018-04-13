alias Shipping.Shipper.Commands.CreateLoad
alias Shipping.Shipper
alias Shipping.Shipper.Load
alias Shipping.Shipper.LoadServer
alias Shipping.Driver.Events.LoadRequestSent
alias Shipping.PubSub


command = %CreateLoad{
  uuid: "uuid",
  shipper_id: "shipper_id",
  car_type: :small,
  number_of_trips: 5,
  start_date_millis: 1000,
  lat: 10.0,
  lng: 10.0
}

command2 = %CreateLoad{
  uuid: "uuid2",
  shipper_id: "shipper_id",
  car_type: :small,
  number_of_trips: 5,
  start_date_millis: 1000,
  lat: 10.0,
  lng: 10.0
}

load_request_event = %LoadRequestSent{
  uuid: "request_uuid",
  load_id: "load_uuid",
  driver_id: "driver_uuid",
  timestamp: 10
}

create_load = %Shipping.Shipper.Commands.CreateLoad{
  uuid: "load_id",
  shipper_id: "shipper_id",
  car_type: :small,
  number_of_trips: 5,
  start_date_millis: 1000,
  lat: 10.0,
  lng: 10.0
}

load_picked_up_event = %Shipping.Driver.Events.LoadPickedUp{
  uuid: "uuid",
  load_request_id: "load_request_id",
  driver_id: "driver_id",
  load_id: "load_id",
  timestamp: 1_515_403_696_862
}

load_delivered_event = %Shipping.Driver.Events.LoadDelivered{
  uuid: "uuid",
  load_id: "load_id",
  timestamp: 1_515_403_696_862
}

# LoadServer.create_load(create_load)
# PubSub.publish("load_picked_up", load_picked_up_event)
# :timer.sleep(10)
# PubSub.publish("load_delivered", load_delivered_event)
# :timer.sleep(10)

:observer.start()
