class Client < ActiveRecord::Base
  belongs_to :gym
  has_many :sessions
  has_many :notes
  has_many :setting_executions
  has_many :exercise_executions, through: :sessions

  def name
    self.first_name + " " + self.last_name
  end

  def get_weight_for_exercise_and_day(exercise_name, date, type)
    # assumes 1 exercise 1 day
    exercise = Exercise.find_by_name(exercise_name)
    executions = self.exercise_executions.for_exercise(exercise.id).for_date(date)

    case type
    when "Weight"
      executions.first.weight if executions.count > 0
    when "Percentage"
      executions.first.percentage if executions.count > 0
    when "Reps"
      executions.first.reps if executions.count > 0
    when "Time"
      executions.first.time if executions.count > 0
    end

    # if type == "Weight"
    #   executions.first.weight if executions.count > 0
    # elsif type == "Percentage"
    #   executions.first.percentage if executions.count > 0
    # elsif type == "Reps"
    #   executions.first.reps if executions.count > 0
    # elsif type == "Time"
    #   executions.first.time if executions.count > 0
    # end

    # if type == "Weight"
    #   if self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.count > 0
    #     self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.first.weight
    #   end
    # elsif type == "Percentage"
    #   if self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.count > 0
    #     self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.first.percentage
    #   end
    # elsif type == "Reps"
    #   if self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.count > 0
    #     self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.first.reps
    #   end
    # elsif type == "Time"
    #   if self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.count > 0
    #     self.exercise_executions.where(exercise_id: exercise.id).select {|ee| ee.created_at.to_date == date}.first.time
    #   end
    # end
  end

  def get_previous_exercise_result(exercise_id)
    self.exercise_executions.where(exercise_id: exercise_id).last
  end
end
