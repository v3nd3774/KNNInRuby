require 'spec_helper'
require 'daru'
require 'lurn'
describe V3ND3774::KNNRegression do
  describe "#predict" do
    let(:k) {5}
    let(:model_under_test) { V3ND3774::KNNRegression.new k }
    let(:reference_model) { Lurn::Neighbors::KNNRegression.new k }
    let(:df) { Daru::DataFrame.from_csv("data/iris.data") }
    let(:resp) { df[2] }
    let(:preds) {
      new_df = df[0..1]
      [3,4].each {|i| new_df[df.vectors.at(i)] = df[i]}
      new_df
    }
    let(:resp_raw) { resp.to_a }
    let(:preds_raw) { preds.to_a[0].map {|h| h.values} }
    before do
      reference_model.fit(preds_raw, resp_raw)
      model_under_test.fit(preds, resp)
    end
    it "returns the average of the nearest neighbor" do
      expect(model_under_test.predict(preds.row[0])).to eq(reference_model.predict(preds_raw[0]))
    end
  end
end
