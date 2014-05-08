class Collapse < ActiveRecord::Base
  validates :new_name, presence: true
  validates :old_name, presence: true, uniqueness: true

  def Collapse.unique_families
    Collapse.select(:new_name).distinct.map { |r| r.new_name }
  end

  def Collapse.family_map
    family_map = {}
    Collapse.all.each do |r|
      if family_map.has_key? r.new_name.to_sym
        family_map[r.new_name.to_sym] << r.old_name
      else
        family_map[r.new_name.to_sym] = [r.old_name]
      end
    end

    return family_map
  end

end
