class Schedule < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validate :availability

  delegate :regularity, to: :section

  def self.add_to_agenda!(section, student)
    self.transaction do
      section.regularity_days.each do |day_time|
        student.schedules.create!(
                  section_id: section.id,
                  beginning_at: day_time,
                  finished_at: day_time + section.duration.minutes
                )
      end
    end
  end

  def self.remove_from_agenda(section, student)
    # I prefer mark records with deleted_at instead of delete them totally,
    # but hope you okay with current solution
    # anyway here is alternative without calling callbacks
    # student.schedules.where(section_id: section.id).update_all(deleted_at: Time.current)

    student.schedules.where(section_id: section.id).destroy_all
  end

  private

  def availability
    errors.add(:base, "Too much lectures to selected time") if time_taken?
  end

  def time_taken?
    student.schedules.where("(beginning_at >= ? AND beginning_at <= ?) OR (finished_at >= ? AND finished_at <= ?)", beginning_at, finished_at, beginning_at, finished_at).any?
  end
end
