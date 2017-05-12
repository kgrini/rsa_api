class Task < ApplicationRecord
  belongs_to :user

  def self.list(flag = 'done')
    where.not(status: flag)
  end

  def close
    update_attribute(
      :status,
      'done'
    )
  end
end
