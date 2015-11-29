class CurrentGroup < ActiveRecord::Base
	# CurrentGroup is a model to keep track of the last group a user was filtering a page by.
	# So when a user chooses to filter by Group A on a page, the following actions will happen:
	#   1) Any previous row in CurrentGroup belonging to the current user will be destroyed.
	#   2) A new row will be created with the id of the current user and the id of the group selected.
	#   3) The next time a user loads a page, it will check first for a row in CurrentGroup belonging
  #      to the current user.
  # The rest of the logic for which group gets loaded under which scenario can be found in /models/user.rb,
  # in the "my_group" method.
  belongs_to :user
end
