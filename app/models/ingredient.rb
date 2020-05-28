class Ingredient < ApplicationRecord
  before_destroy :ensure_no_children

  has_many :doses

  validates :name, uniqueness: true, presence: true

  private

  def ensure_no_children
    unless self.doses.empty?
      raise ActiveRecord::InvalidForeignKey
    end
  end
end
