FactoryBot.define do
  factory :personnel do
    last_name { "さいたま" }
    first_name { '重右衛門' }
    gender { 0 }
    room { 4 }
    birth_date { '1972/11/16' }
    in_date { '2019/06/15' }
    out_plan_date { '2020/02/04' }
    user
  end
end
