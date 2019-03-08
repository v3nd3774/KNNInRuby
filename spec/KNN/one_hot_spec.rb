require 'spec_helper'
require 'daru'
describe  V3ND3774::OneHot do
  describe "#encode" do
    let(:src_df) {
      Daru::DataFrame.new(
        "a" => [1,2,3],
        "b" => ["c", "c", "d"]
      )
    }
    let(:target_df) {
      Daru::DataFrame.new(
        "a" => [1,2,3],
        "b==c" => [1,1,0],
        "b==d" => [0,0,1]
      )
    }
    it "explodes those discrete colums to one hot columns without affecting continous vars" do
      expect()
    end
  end
end
