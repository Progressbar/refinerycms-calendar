require 'spec_helper'

module Refinery
  module Calendar
    describe Engine do
      describe "plugin activity" do
        let(:activity) do
          Refinery::Plugins.registered.find_by_name("refinerycms_calendar").activity.first
        end

        it "sets the correct path for activity entries" do
          activity.url.should eq("refinery.edit_calendar_admin_event_path")
        end
      end

      describe ".load_seed" do
        it "is idempotent" do
          Engine.load_seed
          Engine.load_seed

          Refinery::Page.where(:link_url => '/calendar').count.should eq(1)
        end
      end
    end
  end
end
