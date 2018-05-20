module Slugifable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def slug
    self.name.gsub(" ","-").downcase
  end

  def birth
    return "Unknown" if self.birth_date == "Unknown" && self.birth_place == "Unknown"
    return "Unknown" if self.birth_date.empty? && self.birth_date.empty?
    return "#{self.birth_date}, #{self.birth_place}"
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|u| u.slug == slug}
    end
  end
end
