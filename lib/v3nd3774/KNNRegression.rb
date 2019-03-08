require 'preconditions'
module V3ND3774
  class KNNRegression
    def initialize( k )
      @k = k
    end
    def fit( bigX, y )
      discrete_cols = bigX.vectors.select {|c|
        !(bigX[c][0].is_a? Numeric)
      }
      discrete_values_hash = discrete_cols.inject({}) { |acc,c|
        acc.merge({c => {"values"=> bigX[c], "distinct" => bigX[c].uniq}})
      }
      discrete_cols.each {|c| bigX.delete_vector(c)}
      df_offset = bigX.vectors.size
      discrete_values_hash.each { |colname, hash| 
        one_hot_rows = hash["values"].collect { |value|
	  hash["distinct"].collect { |distinct| value == distinct ? 1 : 0 }
	}
	hash["distinct"].each.with_index { |distinct, idx|
	  bigX["#{colname}==#{distinct}"] = one_hot_rows.collect {|r| r[idx]}
	}
      }
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
      knn_resps.inject(:+).to_f / knn_resps.length
    end
  end
end
