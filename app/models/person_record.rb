# for using in models belongs to person_name
class PersonRecord < NullFlavorRecord
  self.abstract_class = true

  belongs_to :person_name

  accepts_nested_attributes_for :person_name

  def name
    "#{person_name.family} #{person_name.given_1} #{person_name.given_2}".strip
  end

  def initials
    "#{person_name.family} #{person_name.given_1[0, 1]} #{person_name.given_2 && person_name.given_2[0, 1]}".strip
  end

  after_initialize do |person|
    if person.person_name && person.person_name.id == nil
      exist_person_name = PersonName.where(family: person.person_name.family).where(given_1: person.person_name.given_1).where(given_2: person.person_name.given_2)
      person.person_name = exist_person_name.first if exist_person_name && exist_person_name.first
    end
  end

  def self.permitted_params
    [person_name_attributes: [:id, :family, :given_1, :given_2]]
  end
end
