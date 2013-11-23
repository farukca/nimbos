json.array! @reminders do |reminder|
  json.id reminder.id
  json.title reminder.title
  json.start reminder.start_date.strftime("%s")
  json.url reminder_url(reminder, format: :json, remote: true)
  json.edit_url edit_reminder_url(reminder, format: :json)
end