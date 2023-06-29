class Section < ApplicationRecord
  # supose that sections valid per week

  include ::Datable

  AVAILABLE_DURATIONS = [50, 80]

  enum regularity: [:odd, :even, :everyday]

  has_many :schedules
  belongs_to :teacher
  belongs_to :subject

  before_validation :set_default_duration, if: -> { duration.nil? }
  before_validation :set_end_at

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :class_room, presence: true
  validates :duration, inclusion: AVAILABLE_DURATIONS

  private

  def set_default_duration
    self.duration = AVAILABLE_DURATIONS[0]
  end

  def set_end_at
    self.end_at = start_at + duration.minutes
  end
end
