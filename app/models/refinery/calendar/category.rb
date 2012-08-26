module Refinery
	module Calendar
		class Category < ActiveRecord::Base

			extend FriendlyId
			friendly_id :title, :use => [:slugged]

			has_many :categorizations, :dependent => :destroy, :foreign_key => :calendar_category_id
			has_many :events, :through => :categorizations, :source => :calendar_event

			acts_as_indexed :fields => [:title]

			validates :title, :presence => true, :uniqueness => true

			attr_accessible :title
		end
	end
end