module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys, as: :toyable
  end

  def receive_toy(name)
    id = self.id
    type = self.class.name

    Toy.find_or_create_by(name: name, toyable_id: id, toyable_type: type) do |toy|
      toy.toyable_id = id
      toy.toyable_type = type
    end
  end
end