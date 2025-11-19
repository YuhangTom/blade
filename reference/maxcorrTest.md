# Test of the maximum correlation

Test of the maximum correlation

## Usage

``` r
maxcorrTest(sample, block, alpha = 0.05)
```

## Arguments

- sample:

  vector of successive cross-correlation values

- block:

  integer value of the suggested block size. Smaller blocks will create
  larger number of local maxima but increase possible dependence.

- alpha:

  significance value/acceptable level of Type 1 error.

## Value

object of class `htest` (hypothesis test)

## Examples

``` r
# for the example data both a test for the max and a test for the min
# CCF result in the expected outcome:
maxcorrTest(cors_df$ccf, 100) # highly significant
#> 
#>  Max Correlation test
#> 
#> data:  cors_df$ccf
#> max CCF = 0.9264, block = 100, min block = 58, df = 68, shape1 =
#> 3.2355, shape2 = 8.8875, p-value = 3.835e-07
#> alternative hypothesis: The maximum correlation is significantly larger than expected.
#> sample estimates:
#> Max Correlation 
#>       0.9263986 
#> 
maxcorrTest(-cors_df$ccf, 100)  # not significant
#> 
#>  Max Correlation test
#> 
#> data:  -cors_df$ccf
#> max CCF = 0.64286, block = 100, min block = 58, df = 72, shape1 =
#> 2.2771, shape2 = 6.4768, p-value = 0.4905
#> alternative hypothesis: The maximum correlation is significantly larger than expected.
#> sample estimates:
#> Max Correlation 
#>       0.6428583 
#> 
```
