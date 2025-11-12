# Top k clustered local maximums

This function uses density-based spatial clustering of applications with
noise (DBSCAN) to get top k clustered local maximum from an alignment
data frame.

## Usage

``` r
df_topk(data, k = 10, len_block = 100)
```

## Arguments

- data:

  A alignment data frame with two columns: `lag` and `ccf`.

- k:

  A positive integer to control the number of resulting local maximums.

- len_block:

  A positive number controlling the size of neighborhood.

## Value

A data frame with three columns:

- .cluster: The cluster id.

- lag: The lag in the alignment.

- ccf: The cross-correlation value in the alignment.

## Examples

``` r
library(ggplot2)
topk <- df_topk(cors_df)
cors_df %>%
  ggplot(aes(x = lag, y = ccf)) +
  geom_point() +
  geom_point(aes(color = "topk"), data = topk) +
  theme_bw()

```
