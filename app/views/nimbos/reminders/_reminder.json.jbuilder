json.(reminder, :id, :title)
json.start reminder.start_date.strftime("%y-%m-%d")

