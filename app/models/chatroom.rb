# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
	has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :name, presence: true, uniqueness: true
end
