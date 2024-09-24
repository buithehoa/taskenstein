require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TasksHelper. For example:
#
# describe TasksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# spec/helpers/tasks_helper_spec.rb

RSpec.describe TasksHelper, type: :helper do
  let(:task) { build_stubbed(:task) }

  describe "#submit_label" do
    it "returns 'Create' for a new task" do
      allow(task).to receive(:new_record?).and_return(true)
      expect(helper.submit_label(task)).to eq("Create")
    end

    it "returns 'Update' for an existing task" do
      allow(task).to receive(:new_record?).and_return(false)
      expect(helper.submit_label(task)).to eq("Update")
    end
  end

  describe "#priority_label" do
    it "returns the high priority label for a high priority task" do
      allow(task).to receive(:high?).and_return(true)
      expect(helper.priority_label(task)).to eq(Task::PRIORITY_LABELS[:high])
    end

    it "returns the medium priority label for a medium priority task" do
      allow(task).to receive(:high?).and_return(false)
      allow(task).to receive(:medium?).and_return(true)
      expect(helper.priority_label(task)).to eq(Task::PRIORITY_LABELS[:medium])
    end

    it "returns the low priority label for a low priority task" do
      allow(task).to receive(:high?).and_return(false)
      allow(task).to receive(:medium?).and_return(false)
      expect(helper.priority_label(task)).to eq(Task::PRIORITY_LABELS[:low])
    end
  end

  describe "#priorities_for_select" do
    it "returns options for select with the correct priority selected" do
      allow(task).to receive(:priority).and_return(:medium)
      expected_options = options_for_select({
        Task::PRIORITY_LABELS[:low] => :low,
        Task::PRIORITY_LABELS[:medium] => :medium,
        Task::PRIORITY_LABELS[:high] => :high
      }, selected: :medium)
      expect(helper.priorities_for_select(task)).to eq(expected_options)
    end
  end

  describe "#priority_class" do
    it "returns 'bg-danger' for a high priority task" do
      allow(task).to receive(:high?).and_return(true)
      expect(helper.priority_class(task)).to eq('bg-danger')
    end

    it "returns 'bg-warning' for a medium priority task" do
      allow(task).to receive(:high?).and_return(false)
      allow(task).to receive(:medium?).and_return(true)
      expect(helper.priority_class(task)).to eq('bg-warning')
    end

    it "returns 'bg-secondary' for a low priority task" do
      allow(task).to receive(:high?).and_return(false)
      allow(task).to receive(:medium?).and_return(false)
      expect(helper.priority_class(task)).to eq('bg-secondary')
    end
  end
end
