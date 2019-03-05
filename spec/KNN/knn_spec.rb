require 'spec_helper'
require 'daru'
require 'lurn'
describe V3ND3774::KNN do
  describe "#predict" do
    let(:model_under_test) { V3ND3774::KNN.new 3 }
    let(:reference_model) { Lurn::Neighbors::KNNClassifier.new 3 }
    let(:df) { Daru::DataFrame.from_csv("data/iris.data") }
    before do
      preds = df[0..3]
      preds_raw = preds.to_a[0].map {|h| h.values}
      resp = df[4]
      resp_raw = resp.to_a
      reference_model.fit(preds_raw, resp_raw)
      model_under_test.fit(preds, resp)
    end
    it "returns the average of the nearest neighbor" do
      expect(model_under_test.predict(preds.row[0])).to eq(reference_model.predict(preds_raw[0]))
    end
  end
end
