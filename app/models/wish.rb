class Wish < ActiveRecord::Base
  STATUS = {:APPROVED => 1, :DEFAULT => 0}

  belongs_to :user
  belongs_to :book

  def status_str
    if self.status == Wish::STATUS[:DEFAULT]
      '等待审批'
    elsif self.status == Wish::STATUS[:APPROVED]
      '已购入'
    else
      '错误状态'
    end
  end

end
