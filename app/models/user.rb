# frozen_string_literal: true

class User < ApplicationRecord
  include BCrypt

  has_many :tasks

  validates :username, :password_digest, presence: true

  def valid_password?(password)
    Password.new(password_digest) == password
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
