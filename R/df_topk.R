#' Top k clustered local maximums
#'
#' This function uses density-based spatial clustering of applications with noise (DBSCAN) to get top k clustered local maximum from an alignment data frame.
#'
#' @param data A alignment data frame with two columns: `lag` and `ccf`.
#' @param k A positive integer to control the number of resulting local maximums.
#' @param probs A value between 0 and 1 to control the data used for clustering.
#' @param len_block A positive number controlling the size of neighborhood.
#' @return A data frame with three columns:
#' * .cluster: The cluster id.
#' * lag: The lag in the alignment.
#' * ccf: The cross-correlation value in the alignment.
#' @import dplyr
#' @importFrom dbscan dbscan augment
#' @importFrom stats quantile
#' @export
#'
df_topk <- function(data, k = 10, probs = 0.5, len_block = 100) {
  .cluster <-
    ccf <-
    NULL

  data_top <- data %>%
    filter(ccf > quantile(data$ccf, probs))

  db_fit <- dbscan(data_top %>% select(lag),
    minPts = 1,
    eps = len_block / 2
  )

  tops <- db_fit %>%
    augment(data = data_top) %>%
    group_by(.cluster) %>%
    summarise(
      lag = lag[which.max(ccf)],
      ccf = max(ccf)
    )

  tops %>%
    arrange(desc(ccf)) %>%
    slice(1:k)
}
