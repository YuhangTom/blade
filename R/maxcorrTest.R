#' Test of the maximum correlation
#'
#' @param sample vector of successive cross-correlation values
#' @param block integer value of the suggested block size. Smaller blocks will
#' create larger number of local maxima but increase possible dependence.
#' @param alpha significance value/acceptable level of Type 1 error.
#' @returns object of class `htest` (hypothesis test)
#' @importFrom fitdistrplus fitdist
#' @importFrom stats acf pbeta qbeta
#' @export
#' @examples
#' # for the example data both a test for the max and a test for the min
#' # CCF result in the expected outcome:
#' maxcorrTest(cors_df$ccf, 100) # highly significant
#' maxcorrTest(-cors_df$ccf, 100)  # not significant
maxcorrTest <- function(sample, block, alpha = 0.05) {
  ccf <- NULL

  # the assumption is that the ccf is a series of successive values
  cors_df <- data.frame(lag = 1:length(sample), ccf = sample)
  res <- acf(sample, lag.max = length(sample) - 1, plot = FALSE)
  min_block <- which(res$acf < 0)[1]
  if (block < min_block) {
    stop(sprintf("Minimal block length is larger than set block length (%d > %d)", min_block, block))
  }
  maxima <- df_topk(cors_df, k = 1000, len_block = block) # set k to Inf

  # install.packages("fitdistrplus")
  # library(fitdistrplus)
  # library(VGAM)
  # fit_fr <- fitdistr(maxima$ccf, dfrechet, start = list(shape = 1, scale = 1, location = .5))

  # hist(rfrechet(n = 1000, location = mean(maxima$ccf), shape=1, scale = sd(maxima$ccf)))

  maxcorr <- max(maxima$ccf)
  # browser()
  maxima <- maxima |> filter(!near(ccf, maxcorr))
  # max_density <- density(maxima$ccf)

  beta_fit <- fitdist(maxima$ccf, "beta")
  # summary(beta_fit)
  #
  # plot(beta_fit)
  DNAME <- deparse(substitute(sample))
  p.value <- 1 - (pbeta(maxcorr, shape1 = beta_fit$estimate[1], shape2 = beta_fit$estimate[2]))^(nrow(maxima) + 1)
  Ca <- qbeta(alpha,
    shape1 = beta_fit$estimate[1],
    shape2 = beta_fit$estimate[2], lower.tail = FALSE
  )
  alternative_msg <- "The maximum correlation is significantly larger than expected."
  structure(list(
    statistic = list(`max CCF` = maxcorr),
    parameter = list(
      block = block, `min block` = min_block,
      df = length(maxima$ccf),
      shape1 = beta_fit$estimate[1],
      shape2 = beta_fit$estimate[2]
    ),
    p.value = p.value,
    estimate = c(`Max Correlation` = maxcorr),
    method = "Max Correlation test",
    critical = Ca, alpha = alpha, alternative = alternative_msg,
    data.name = DNAME
  ), class = c("htest", "maxcorr"))
}
