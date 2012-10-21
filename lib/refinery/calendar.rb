require 'refinerycms-core'
require 'acts_as_indexed'

module Refinery
  autoload :CalendarGenerator, 'generators/refinery/calendar_generator'

  module Calendar
    require 'refinery/calendar/engine'
    require 'refinery/calendar/configuration'

    autoload :Version, 'refinery/calendar/version'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def version
        ::Refinery::Calendar::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end