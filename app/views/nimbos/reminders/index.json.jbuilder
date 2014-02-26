json.array! @reminders do |reminder|
  json.id reminder.id
  json.title reminder.title
  json.start reminder.start_date.strftime("%s")
  json.end reminder.finish_date.strftime("%s") unless reminder.finish_date.blank?
  json.url edit_reminder_url(reminder), remote: true
end