require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:task) { create(:task) }

  describe "PATCH /tasks/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Task Title" } }

      it "updates the requested task" do
        patch task_path(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Task Title")
      end

      it "redirects to the task" do
        patch task_path(task), params: { task: new_attributes }
        expect(response).to redirect_to(task)
      end

      it "renders turbo stream response" do
        patch task_path(task), params: { task: new_attributes }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: "" } }

      it "renders turbo stream response" do
        patch task_path(task), params: { task: invalid_attributes }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end
  end

  describe "DELETE /tasks/:id" do
    it "destroys the requested task" do
      task = create(:task)
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete task_path(task)
      expect(response).to redirect_to(tasks_path)
    end
  end

  describe "PATCH /tasks/:id/complete" do
    it "marks the task as completed" do
      patch complete_task_path(task)
      task.reload
      expect(task.completed).to be_truthy
    end

    it "renders turbo stream response" do
      patch complete_task_path(task), headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
    end

    it "redirects to the tasks list" do
      patch complete_task_path(task)
      expect(response).to redirect_to(tasks_path)
    end
  end
end
