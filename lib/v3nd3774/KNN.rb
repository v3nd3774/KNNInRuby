require 'preconditions'
module V3ND3774
  class KNN
    def initialize( k )
      @k = k
    end
    def fit( bigX, y )
      @preds = bigX
      @resp = y
    end
    def predict( x )
      Preconditions.check_argument(@preds.shape[1] == x.to_a.length,
        "row vector x must be same size as a row of matrix X.")
      distances = @preds.collect(axis=:row) {|r|
        Math.sqrt(
          r.to_a.zip(x.to_a).collect {|r_i,x_i| (r_i - x_i)**2}.reduce(0) { |sum,element|
            sum + element
          }
        )
      }
      sorted_dist = distances.each_with_index.sort_by {|tup| tup[0]}
      knn = sorted_dist[0..(@k-1)]
      knn_resps = knn.collect {|tup| @resp[tup[1]]}
      knn_votes_sorted = knn_resps.group_by {|response| response}.map {|r,xs_r|
        [r,xs_r.length]}.sort_by {|tup| tup[1]}.reverse
      knn_votes_sorted[0][0]
    end
  end
end
