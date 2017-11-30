require_relative "methods.rb"

IO.write("answer.csv", "user_id,n,sum,min,max", mode: "w+")
user = User.new("1")

3.times do |num|
  IO.foreach("transactions#{num + 1}.csv") do |line|
    next if line.match("user_id")
    data = parse_line(line)
    if user.user_id != data[:user_id]
      Thread.new {IO.write("answer.csv", reduce(user), mode: "a+")}.join unless user.user_id == "1"
      user = User.new(data[:user_id])
    end
    user.dates[data[:date]] ||= []
    user.dates[data[:date]] << data[:amount]
  end
end

Thread.new {IO.write("answer.csv", reduce(user), mode: "a+")}.join