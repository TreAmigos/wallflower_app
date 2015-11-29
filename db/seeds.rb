DEFAULT_EMAIL = "tres_amigos@wallflower.com"
DEFAULT_PASSWORD = "password"
DEFAULT_GROUP = "Tres Amigos Family"
DEFAULT_EVENT = "Watch Tres Amigos Movie"
DEFAULT_EVENT_DESCRIPTION = "This move is what we're all about!"
DEFAULT_EVENT_TIME = Time.now + 7.days

# These seeds create the following:
# 1) User with email DEFAULT_EMAIL
# 2) Group with name DEFAULT_GROUP
# 3) GroupMembership with user_id of (1) and group_id of (2)
# 4) CurrentGroup set to (2).  CurrentGroup is a tracker of the last group the user was filtering a page by
# 5) Event with title DEFAULT_EVENT and set for a week from now
# 6) UserEvent with user_id of (1) and event_id of (5)

puts "\n---------------STARTING SEEDS-------------------\n"
# Create default user
puts "...Creating default user: #{DEFAULT_EMAIL}"
if user = User.find_by_email(DEFAULT_EMAIL)
	puts "\t\tDefault user already exists: #{user.attributes}"
else
	user = User.create(
		name: "Tres Amigos", 
		email: DEFAULT_EMAIL, 
		password: DEFAULT_PASSWORD, 
		confirmed_at: Time.now, 
		confirmation_sent_at: Time.now
		)
	puts "\t\tDefault user created: #{user.attributes}"
end

# Create default group
puts "...Creating group: #{DEFAULT_GROUP}"
if group = Group.find_by_name(DEFAULT_GROUP)
	puts "\t\tDefault group already exists: #{group.attributes}"
else
	group = Group.create(name: DEFAULT_GROUP)
	puts "\t\tDefault group created: #{group.attributes}"
end

# Enroll user in group membership
puts "...Creating group membership"
if membership = GroupMembership.find_by_user_id_and_group_id(user.id, group.id)
	puts "\t\tGroup membership already exists: #{membership.attributes}"
else
	membership = GroupMembership.create(user_id: user.id, group_id: group.id)
	puts "\t\tGroup membership created: #{membership.attributes}"
end

# Set current group to group created above
puts "...Setting current group: #{group.attributes}"
if current_group = CurrentGroup.find_by_user_id(user.id)
	puts "\t\tCurrent Group already set to: #{current_group.attributes}"
else
	current_group = CurrentGroup.create(user_id: user.id, group_id: group.id)
	puts "\t\tCurrent group set to: #{current_group.attributes}"
end

# Create default event
puts "...Creating default event: #{DEFAULT_EVENT}"
if event = Event.find_by_title(DEFAULT_EVENT)
	puts "\t\tEvent already exists: #{event.attributes}"
else
	event = Event.create(title: DEFAULT_EVENT, description: DEFAULT_EVENT_DESCRIPTION, event_at: DEFAULT_EVENT_TIME)
	puts "\t\tDefault event created: #{event.attributes}"
end

# Create default user event
puts "...Creating default user event"
if user_event = UserEvent.find_by_user_id_and_event_id(user.id, event.id)
	puts "\t\tUser event already exists: #{user_event.attributes}"
else
	user_event = UserEvent.create(user_id: user.id, event_id: event.id)
	puts "\t\tDefault user event created: #{user_event.attributes}"
end

puts "\n---------------DONE SEEDING-------------------\n"