require_relative "user.rb"

def parse_line(line)
  user_id       = line[0..15]
  amount        = line.match(/\|(.{1,10}\...)\|/)[1].to_f
  date          = line.match(/\d{4}\-\d{2}\-\d{2}/)[0]
  type          = line.match(/credit/) ? "credit" : "debit"
  true_number   = (type == "credit") ? amount : -amount

  {
    user_id: user_id,
    amount: true_number,
    date: date
  }
end

def reduce(user)
  user.dates.sort.each do |date, transactions|
    user.n   += transactions.count
    user.sum += transactions.sum
    user.min = user.sum if user.sum < user.min
    user.max = user.sum if user.sum > user.max
  end
  "\n#{user.user_id},#{user.n},#{'%.2f' % user.sum.round(2)},#{'%.2f' % user.min.round(2)},#{'%.2f' % user.max.round(2)}"
end