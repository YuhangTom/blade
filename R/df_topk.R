#' Top k clustered local maximums
#'
#' This function uses density-based spatial clustering of applications with noise (DBSCAN) to get top k clustered local maximum from an alignment data frame.
#'
#' @param data A alignment data frame with two columns: `lag` and `ccf`.
#' @param k A positive integer to control the number of resulting local maximums.
#' @param len_block A positive number controlling the size of neighborhood.
#' @return A data frame with three columns:
#' * .cluster: The cluster id.
#' * lag: The lag in the alignment.
#' * ccf: The cross-correlation value in the alignment.
#' @import dplyr
#' @import ggplot2
#' @importFrom dbscan dbscan augment
#' @importFrom stats quantile
#' @export
#' @examples
#' library(ggplot2)
#' topk <- df_topk(cors_df)
#' cors_df %>%
#'   ggplot(aes(x = lag, y = ccf)) +
#'   geom_point() +
#'   geom_point(aes(color = "topk"), data = topk) +
#'   theme_bw()
#'
df_topk <- function(data, k = 10, len_block = 100) {
  .cluster <-
    ccf <-
    NULL

  data_top <- data %>%
    filter(ccf > 0)

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

  if (is.numeric(k)) {
    tops %>%
      arrange(desc(ccf)) %>%
      slice(1:k)
  } else {
    ### For infinity
    tops %>%
      arrange(desc(ccf))
  }
}
