module TasksHelper
  def priority_label(task)
    if task.high?
      'High Priority'
    elsif task.medium?
      'Medium Priority'
    else
      'Low Priority'
    end
  end

  def priority_class(task)
    if task.high?
      'bg-danger'
    elsif task.medium?
      'bg-warning'
    else
      'bg-secondary'
    end
  end
end
