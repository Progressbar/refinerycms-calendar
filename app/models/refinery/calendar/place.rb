module Refinery
  module Calendar
    class Place < Refinery::Core::BaseModel
      has_many :events
	    belongs_to :image, :class_name => 'Refinery::Image', :foreign_key => :image_id
	  
      validates :name, :presence => true

      attr_accessible :name, :description, :url, :image_id
      attr_accessible :phone, :email
      attr_accessible :address_country, :address_locality, :address_region, :postal_code, :street_address
      attr_accessible :latitude, :longitude

      def title
        title = self.name
        title << ", #{self.street_address}" if self.street_address.present?
        title << ", #{self.address_locality}" if self.address_locality.present?
        title
      end

    end
  end
end