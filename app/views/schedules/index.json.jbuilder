
json.array! @events do |event|
  json.id event.id
  json.title "#{event.room.name} #{event.starts_at.strftime('%H:%M:%S')}"
  json.resourceId event.room.id
  json.start event.starts_at
  json.url "/rooms/#{event.room.id}?schedule=#{event.id}"
  if event.starts_at <= Time.zone.now && event.ends_at >= Time.zone.now
    json.color '#06d6a0'
  elsif event.ends_at < Time.zone.now
    json.color '#e63946'
  else
    json.color '#fca311'
    json.textColor 'black'
  end
end