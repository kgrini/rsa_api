class Task < ApplicationRecord
  belongs_to :user

  before_save :default_values, on: :create

  def self.list(conditions)
    where(
      status: conditions[:status] ? conditions[:status] : 'new',
      tag: conditions[:tag]
    )
  end

  def close
    update_attribute(
      :status,
      'done'
    )
  end

  private

  def default_values
    self.status ||= 'new'
    self.tag = self.tag.downcase
  end
end
