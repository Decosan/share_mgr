class Personnel < ApplicationRecord
  belongs_to :user
  enum room: {
    '101a': 0,
    '101b': 1,
    '201a': 2,
    '201b': 3,
    '202a': 4,
    '202b': 5,
    '203a': 6,
    '203b': 7,
    '204a': 8,
    '204b': 9,
    '205a': 10,
    '205b': 11,
    '206a': 12,
    '206b': 13,
    '207a': 14,
    '207b': 15,
    '208a': 16,
    '208b': 17,
  }
  enum gender: {
    "男性": 0,
    "女性": 1,
  }
end
