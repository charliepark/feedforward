class Link < ActiveRecord::Base
  belongs_to :user
  has_one :podcast
  has_one :link_hit, as: :linkable
  has_many :comments, as: :commentable

  attr_accessible :title, :url, :podcast_attributes
  accepts_nested_attributes_for :podcast

  validates :title, :url, presence: true
end
