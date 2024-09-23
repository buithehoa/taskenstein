module TasksHelper
  def priority_label(task)
    if task.high?
      Task::PRIORITY_LABELS[:high]
    elsif task.medium?
      Task::PRIORITY_LABELS[:medium]
    else
      Task::PRIORITY_LABELS[:low]
    end
  end

  def priorities_for_select(task)
    options_for_select({
      Task::PRIORITY_LABELS[:low] => :low,
      Task::PRIORITY_LABELS[:medium] => :medium,
      Task::PRIORITY_LABELS[:high] => :high
    }, selected: task.priority)
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
