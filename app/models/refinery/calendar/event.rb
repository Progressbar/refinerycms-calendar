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
      
      has_many :dates, :class_name => 'Refinery::Calendar::Date', :dependent => :destroy

      accepts_nested_attributes_for :dates

      validates :title, :presence => true
      validates :published_at, :presence => true
      validate :dates_presence
      validate :ends_after_start

      alias_attribute :title, :name

      attr_accessible :title, :description,
                      :draft, :published_at, :featured,
                      :image_id, :category_ids, :location_id, :user_id, :dates_attributes

      acts_as_indexed :fields => [:title, :description]


      before_save :update_start_end_date
      # before_update :update_start_end_date


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

      def duration_unit
        if dates.any? and dates.first.date_time.strftime('%j') != dates.second.date_time.strftime('%j')
          return :days
        end

        return :hours
      end

      def duration_in?(unit)
        unit.to_sym == duration_unit
      end

      class << self

        def upcoming
          where('start_date >= ? OR (start_date < ? AND end_date >= ?)', Time.now, Time.now, Time.now)
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
          with_exclusive_scope { order('start_date DESC').live.where 'end_date < ?', Time.now }
        end
        
        def by_archive archive_date
          with_exclusive_scope { order('start_date DESC').live.where 'start_date between ? and ?', archive_date.beginning_of_month, archive_date.end_of_month }
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
        errors.add(:base, "End at date must be after the start at date") if self.dates.last.date_time < self.dates.first.date_time
      end

      def dates_presence
        errors.add(:base, "Date must be filled") if self.dates.empty?
      end

      def update_start_end_date
        self[:start_date] = self.dates.first.date_time
        self[:end_date] = self.dates.last.date_time
      end
    end
  end
end