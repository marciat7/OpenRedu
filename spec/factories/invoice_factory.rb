Factory.define(:invoice) do |i|
  i.period_start Date.today
  i.period_end(Date.today + 15)
  i.amount 150.25
  i.association :plan
end