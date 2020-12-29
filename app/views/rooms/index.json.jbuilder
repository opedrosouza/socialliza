hours = { 
  businessHours: {
    startTime: '10:00',
    endTime: '18:00'
  } 
}
json.array! @rooms do |room|
  json.id room.id
  json.title room.name
end