# Top k clustered local maximums

This function uses density-based spatial clustering of applications with
noise (DBSCAN) to get top k clustered local maximum from an alignment
data frame.

## Usage

``` r
df_topk(data, k = 10, probs = 0.5, len_block = 100)
```

## Arguments

- data:

  A alignment data frame with two columns: `lag` and `ccf`.

- k:

  A positive integer to control the number of resulting local maximums.

- probs:

  A value between 0 and 1 to control the data used for clustering.
  (XXX...Rephrase)

- len_block:

  A positive number controlling the size of neighborhood.

## Value

A data frame with three columns:

- .cluster: The cluster id.

- lag: The lag in the alignment.

- ccf: The cross-correlation value in the alignment.
