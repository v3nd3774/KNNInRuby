# KNNInRuby

### How to run?
`git clone` this repo, then `cd` to it's directory. Finally, run `rake`. This will hook into the `Rakefile`
which will use `rspec` to run the unit test in `spec/KNN/knn_spec.rb`.

This unit test will load in the `Lurn::Neighbors::KNNClassifier` and run a single test (maybe more later?)
against this implementation to assert whether the implementation of `V3ND3774::KNN` in `lib/v3nd3774/KNN.rb`
is accurate.

## Data source?
Data used is from [**UC Irvine Machine Learning Repository Iris Dataset**](https://archive.ics.uci.edu/ml/datasets/Iris).
