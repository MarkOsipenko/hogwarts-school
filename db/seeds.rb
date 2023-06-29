# ---------------- ODD ----------------
t1 = Teacher.create!(first_name: "Severus", last_name: "LastName" )
t2 = Teacher.create!(first_name: "Minerva", last_name: "LastName" )
t3 = Teacher.create!(first_name: "Hagrid", last_name: "LastName" )

s1 = Subject.create!(name: "Poison")
s2 = Subject.create!(name: "Magic")
s3 = Subject.create!(name: "History")

# M W F at 7:30
valid_section_odd1 = Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 1, 7, 30), class_room: 1, regularity: :odd)
invalid_section_odd1 = Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 1, 7, 30), class_room: 2, regularity: :odd)

Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 1, 7, 30), class_room: 3, regularity: :odd)
# M W F at 8:30
valid_section_odd2 = Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 1, 8, 30), class_room: 1, regularity: :odd)
Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 1, 8, 30), class_room: 2, regularity: :odd)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 1, 8, 30), class_room: 3, regularity: :odd)

# M W F at 9:30
Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 1, 8, 30), class_room: 2, regularity: :odd)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 1, 8, 30), class_room: 3, regularity: :odd)
# M W F at 10:30
Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 1, 10, 30), class_room: 1, regularity: :odd)
Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 1, 10, 30), class_room: 2, regularity: :odd)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 1, 10, 30), class_room: 3, regularity: :odd)

# ---------------- EVEN ----------------

t1 = Teacher.create(first_name: "Weesly", last_name: "LastName" )
t2 = Teacher.create(first_name: "Malfoy", last_name: "LastName" )
t3 = Teacher.create(first_name: "Lupin", last_name: "LastName" )

s1 = Subject.create(name: "Beasts")
s2 = Subject.create(name: "Quidditch")
s3 = Subject.create(name: "Magls")

# T T at 7:30
valid_section_even1 = Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 2, 7, 30), class_room: 1, regularity: :even)
invalid_section_even1 = Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 2, 7, 30), class_room: 2, regularity: :even)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 2, 7, 30), class_room: 3, regularity: :even)
# T T at 8:30
Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 2, 8, 30), class_room: 1, regularity: :even)
valid_section_even2 = Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 2, 8, 30), class_room: 2, regularity: :even)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 2, 8, 30), class_room: 3, regularity: :even)
# T T at 9:30

Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 2, 9, 30), class_room: 2, regularity: :even)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 2, 9, 30), class_room: 3, regularity: :even)
# T T at 10:30
Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 2, 10, 30), class_room: 1, regularity: :even)
Section.create!(teacher_id: t2.id, subject_id: s2.id, start_at: DateTime.new(2022, 8, 2, 10, 30), class_room: 2, regularity: :even)
Section.create!(teacher_id: t3.id, subject_id: s3.id, start_at: DateTime.new(2022, 8, 2, 10, 30), class_room: 3, regularity: :even)

# ---------------- EVERYDAY ----------------

t1 = Teacher.create(first_name: "Weesly", last_name: "lastName")
s1 = Subject.create(name: "Beasts")
section1 = Section.create!(teacher_id: t1.id, subject_id: s1.id, start_at: DateTime.new(2022, 8, 1, 9, 30), class_room: 1, regularity: :everyday)

harry = Student.create(full_name: 'Harry Potter')

# ---------- tests --------------

Schedule.add_to_agenda!(valid_section_odd1, harry) # create valid schedules for Harry for M W F at 7:30 class room №1
Schedule.add_to_agenda!(valid_section_even1, harry) # create valid schedules for Harry for T T  at 7:30

begin
  Schedule.add_to_agenda!(invalid_section_odd1, harry) # try to create one more schedule to M W F at 7:30 but in class room №2
rescue ActiveRecord::RecordInvalid
  p "it was try to add one more section on specific time"
end

# Harry's agenda now:
# Poison section (prof. Severus) - M W F - 7:30
# Quidditch section (prof. Malfoy) - T T  - 7:30

Schedule.remove_from_agenda(valid_section_odd1, harry) # remove schedule for M W F at 7:30 class room №1
Schedule.add_to_agenda!(invalid_section_odd1, harry) # now we can add M W F at 7:30 class room №2

# Agenda now:
# Magic section (prof. Minerva) - M W F - 7:30
# Quidditch section (prof. Malfoy) - T T  - 7:30

Schedule.add_to_agenda!(valid_section_even2 , harry)

# Agenda now:
# Magic section (prof. Minerva) - M W F - 7:30
# Quidditch section (prof. Malfoy) - T T  - 7:30
# Beasts section (prof. Weesly) - T T  - 8:30

result = harry.schedules.joins(section: [:teacher, :subject])
                        .select("schedules.beginning_at, teachers.first_name, subjects.name")

result.each do |schedule|
  p "#{schedule.beginning_at} / #{schedule.first_name} / #{schedule.name}}"
end
