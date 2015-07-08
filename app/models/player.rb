class Player < ActiveRecord::Base

  validates :name, presence: true
  validates :country, presence: true

  def as_json(options = {})
    super( only: [:name, :number, :country] )
  end

  def to_xml(options = {})
    super( only: [:name, :number] )
  end
end
