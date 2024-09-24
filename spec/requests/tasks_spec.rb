require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:task) { create(:task) }

  describe "GET /tasks" do
    let!(:task1) { create(:task, completed: false, due_at: 1.day.from_now) }
    let!(:task2) { create(:task, completed: false, due_at: 2.days.from_now) }
    let!(:completed_task) { create(:task, completed: true, due_at: 3.days.from_now) }

    it "assigns @pagy and @tasks" do
      get tasks_path
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(assigns(:tasks)).to match_array([task1, task2])
    end

    it "renders the index template" do
      get tasks_path
      expect(response).to render_template(:index)
    end

    it "returns a successful response" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

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
