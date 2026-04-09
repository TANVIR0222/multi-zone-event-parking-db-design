VehicleRegistration [icon : car] {
  id SERIAL PK
  owner_name VARCHAR(50)
  phone_number VARCHAR(15)

  vehicle_number VARCHAR(20) UNIQUE
  vehicle_type_id INT FK
  user_type_id INT FK

  duration INT DEFAULT 30 

  is_ev BOOLEAN DEFAULT FALSE
  charging_required BOOLEAN DEFAULT FALSE
  charging_duration INT NULL

  entry_time TIMESTAMP
  exit_time TIMESTAMP

  status VARCHAR(20) //parked, exited

  created_at TIMESTAMP
}

VehicleType {
  id SERIAL PK
  name VARCHAR(20) 
}

UserType {
  id SERIAL PK
  name VARCHAR(30)
}
ParkingSlot {
  id SERIAL PK
  slot_number VARCHAR(20) UNIQUE

  zone VARCHAR(30) // Bike, Car, VIP, EV, Staff

  vehicle_type_id INT FK

  is_ev_slot BOOLEAN DEFAULT FALSE
  is_occupied BOOLEAN DEFAULT FALSE

  allowed_user_type_id INT FK NULL
}

ParkingPrice {
  id SERIAL PK
  vehicle_type_id INT FK
  user_type_id INT FK NULL  

  base_price_per_hour DECIMAL(10,2)

  price_multiplier DECIMAL(3,2) DEFAULT 1.00
  // VIP = 1.5 / 2.0

  created_at TIMESTAMP
  updated_at TIMESTAMP
}

EVCharging {
  id SERIAL PK
  vehicle_id INT FK

  start_time TIMESTAMP
  end_time TIMESTAMP

  units_consumed DECIMAL(10,2)
  price DECIMAL(10,2)
}

VehicleLocation {
  id SERIAL PK
  vehicle_id INT FK

  slot_id INT FK
  serial_number VARCHAR(20)

  assigned_at TIMESTAMP
}

ParkingSession {
  id SERIAL PK

  vehicle_id INT FK
  slot_id INT FK

  ticket_id INT FK

  entry_time TIMESTAMP
  exit_time TIMESTAMP NULL

  status VARCHAR(20) // active, completed

  created_at TIMESTAMP
}

ParkingTicket {
  id SERIAL PK

  ticket_number VARCHAR(50) UNIQUE

  issued_at TIMESTAMP

  vehicle_id INT FK
}

Payment {
  id SERIAL PK

  session_id INT FK

  amount DECIMAL(10,2)
  payment_status VARCHAR(20) //pending, paid

  payment_method VARCHAR(20) // cash, card, online

  paid_at TIMESTAMP
}

ParkingZone {
  id SERIAL PK
  name VARCHAR(30) 
  description VARCHAR(100)
  is_active BOOLEAN DEFAULT TRUE
}

ParkingLevel {
  id SERIAL PK
  level_name VARCHAR(20) 
  max_height_limit DECIMAL(4,2)
  total_capacity INT
}

SlotCategory {
  id SERIAL PK
  name VARCHAR(30)  //VIP, Staff, Cosplayer, EV
  reservation_priority INT 
  min_required_clearance DECIMAL(4,2)
}

ParkingAvailability {
  id SERIAL PK

  zone_id INT FK
  level_id INT FK

  total_slots INT
  available_slots INT

  updated_at TIMESTAMP
}




// (Master Tables)
VehicleType.id < VehicleRegistration.vehicle_type_id
UserType.id < VehicleRegistration.user_type_id
VehicleType.id < ParkingSlot.vehicle_type_id
SlotCategory.id < ParkingSlot.category_id

// ২.
ParkingZone.id < ParkingSlot.zone_id
ParkingLevel.id < ParkingSlot.level_id
ParkingZone.id < ParkingAvailability.zone_id
ParkingLevel.id < ParkingAvailability.level_id

// 
VehicleRegistration.id < ParkingSession.vehicle_id
ParkingSlot.id < ParkingSession.slot_id
ParkingTicket.id - ParkingSession.ticket_id 
VehicleRegistration.id < ParkingTicket.vehicle_id

//
ParkingSession.id - Payment.session_id 
ParkingSession.id < EVCharging.session_id
VehicleRegistration.id < VehicleLocation.vehicle_id
ParkingSlot.id < VehicleLocation.slot_id

// ৫.
VehicleType.id < ParkingPrice.vehicle_type_id
UserType.id < ParkingPrice.user_type_id
