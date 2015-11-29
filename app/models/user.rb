class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_one :current_group

  DEFAULT_NO_GROUP_MESSAGE = "Join or create a group!"

  def my_group
    # My group first looks at current_group, which shows last group user selected
    # then looks at preferred_group_id if set
    # then just chooses the first group this user belongs to
    # and if all those fail defaults to "Join a group!"
    if current_group
      Group.find(current_group.group_id).name
    elsif preferred_group_id
      Group.find(preferred_group_id).name
    elsif groups.first
      groups.first.name
    else
      DEFAULT_NO_GROUP_MESSAGE
    end
  end
end
