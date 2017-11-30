class User
  attr_accessor :n, :sum, :min, :max, :dates
  attr_reader :user_id
  def initialize(user_id)
    @user_id = user_id
    @n       = 0
    @sum     = 0
    @min     = 0
    @max     = 0
    @dates   = {}
  end
end