module Refinery
  module Calendar

    class Event < Refinery::Core::BaseModel

      extend FriendlyId

      friendly_id :title, :use => :slugged
 
      belongs_to :place, :class_name => 'Refinery::Calendar::Place', :foreign_key => :location_id
      belongs_to :image, :class_name => 'Refinery::Image', :foreign_key => :image_id
      belongs_to :user, :class_name => 'Refinery::User', :foreign_key => :user_id
      
      has_many :categorizations, :class_name => 'Refinery::Calendar::Categorization', :dependent => :destroy, :foreign_key => :calendar_event_id
      has_many :categories, :through => :categorizations, :source => :calendar_category

      validates :title, :presence => true
      validates :published_at, :presence => true
      validates :start_date, :end_date, :presence => true
      validate :ends_after_start

      alias_attribute :title, :name

      attr_accessible :title, :description, :start_date, :end_date,
                      :draft, :published_at, :featured, :position,
                      :image_id, :category_ids, :location_id

      acts_as_indexed :fields => [:title, :description]

      def current?
        end_date >= Time.now
      end
      
      def upcoming?
        start_date >= Time.now
      end
      
      def archived?
        end_date < Time.now
      end
      
      def featured?
        featured == true
      end

      def live?
        !draft and published_at <= Time.now
      end

      def next
        Event.published_before.where(['start_date > ?', start_date]).first
      end
      
      def prev
        Event.published_before.where(['start_date < ?', start_date]).reverse.first
      end

      class << self

        def upcoming
          where('start_date >= ?', Time.now)
        end

        def today
          where('start_date between ? and ?', Time.now.beginning_of_day, Time.now.end_of_day)
        end

        def featured
          where(:featured => true)
        end

        def published_before(date=Time.now)
          where("published_at < ? and draft = ?", date, false)
        end

        alias_method :live, :published_before

        def archive
          with_exclusive_scope { order('start_date DESC').where 'end_date < ?', Time.now }
        end
        
        def by_archive archive_date
          with_exclusive_scope { order('start_date DESC').where 'start_date between ? and ?', archive_date.beginning_of_month, archive_date.end_of_month }
        end
        
        def by_year archive_date
          where(['start_date between ? and ?', archive_date.beginning_of_year, archive_date.end_of_year])
        end

        def for_archive_list
          with_exclusive_scope { order('start_date DESC').where(['end_date < ?', Time.now.beginning_of_month]) }
        end

      end

      private

      def ends_after_start
        errors.add(:base, "End at date must be after the start at date") if end_date < start_date
      end

    end
  end
end
