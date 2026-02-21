# == Schema Information
#
# Table name: locations
#
#  id          :bigint           not null, primary key
#  address     :string
#  city        :string
#  description :string
#  image       :string
#  name        :string
#  postal_code :string
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  host_id     :integer
#
class Location < ApplicationRecord

  belongs_to :host, required: true, class_name: "User", foreign_key: "host_id", counter_cache: true

  has_many  :bookings, class_name: "Booking", foreign_key: "location_id", dependent: :destroy

  mount_uploader :image, ImageUploader
  
end
