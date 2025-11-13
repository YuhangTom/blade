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
#> Error in maxcorrTest(cors_df$ccf, 100): could not find function "maxcorrTest"
maxcorrTest(-cors_df$ccf, 100)  # not significant
#> Error in maxcorrTest(-cors_df$ccf, 100): could not find function "maxcorrTest"
```
