class ScreenwriterMovie < ActiveRecord::Base
  belongs_to :screenwriter
  belongs_to :movie
end
