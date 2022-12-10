Stepwise Regression
================

## Using Stepwise Selection for Linear Regression: Is the Bechdel test a significant predictor of movie success?

In order to assess whether a movie passing the Bechdel test is a
significant predictor of that movie’s success, we utilized a stepwise
selection algorithm. The `stepAIC` command from the `MASS` package
performs stepwise model selection by optimizing AIC.

The setup of the regression models here follows the methodology outlined
previously including log-transforming variables like `profit` and
`budget_2013` to enforce a normal distribution.

### Profit

We first assessed the Bechdel test as a potential predictor of `profit`.
Other potential predictors included in the model were `budget_2013`,
review ratings (either `imdb_rating` or `metascore`), and all genre
variables. There was no difference in the inclusion of the Bechtel test
predictor between usage of `imdb_rating` or `metascore` so only IMDB
models are presented here for simplicity. Additionally, the binary
Bechdel test variable was applied in these models to optimize degrees of
freedom.

``` r
# Stepwise regression for Profit
## logProfit ~ Bechdel (binary) + logBudget + IMDB + Genre
model11 = lm(log(profit +1) ~ pass_bechdel + log(budget_2013) + imdb_rating + action + adventure + animation + biography + comedy + crime + documentary + drama + family + fantasy + history + horror + music + musical + mystery + romance + sci_fi + sport + thriller + war + western, data = movies_df)
step11 <- stepAIC(model11, direction = "both", trace = FALSE) %>% broom::tidy()
knitr::kable(step11, digits = 3)
```

| term             | estimate | std.error | statistic | p.value |
|:-----------------|---------:|----------:|----------:|--------:|
| (Intercept)      |    4.205 |     0.599 |     7.020 |   0.000 |
| log(budget_2013) |    0.646 |     0.030 |    21.721 |   0.000 |
| imdb_rating      |    0.395 |     0.041 |     9.539 |   0.000 |
| adventureTRUE    |    0.453 |     0.101 |     4.463 |   0.000 |
| biographyTRUE    |   -0.338 |     0.179 |    -1.886 |   0.060 |
| dramaTRUE        |   -0.369 |     0.085 |    -4.330 |   0.000 |
| horrorTRUE       |    0.547 |     0.128 |     4.264 |   0.000 |
| musicTRUE        |    0.481 |     0.262 |     1.834 |   0.067 |
| romanceTRUE      |    0.197 |     0.107 |     1.848 |   0.065 |
| sci_fiTRUE       |   -0.210 |     0.113 |    -1.851 |   0.064 |
| westernTRUE      |   -2.685 |     0.496 |    -5.412 |   0.000 |

The algorithm selected budget, review ratings, and the genre variables
of adventure, biography, drama, horror, music, romance, sci-fi, and
western as influential predictors of a movie’s profit. The Bechdel test
was not selected as an influential predictor.

### Budget

As budget is a significant predictor of movie success (as assessed by
profit - see table above), we also assessed whether passing the Bechdel
test is an influential predictor of a movie’s budget. Other potential
predictors we included in the model are `runtime` and all genre
variables.

``` r
## logBudget ~ Bechdel (binary) + runtime + Genre
model19 = lm(log(budget_2013) ~ pass_bechdel + runtime + action + adventure + animation + biography + comedy + crime + documentary + drama + family + fantasy + history + horror + music + musical + mystery + romance + sci_fi + sport + thriller + war + western, data = movies_df)
step19 <- stepAIC(model19, direction = "both", trace = FALSE) %>%  broom::tidy()
knitr::kable(step19, digits = 3)
```

| term            | estimate | std.error | statistic | p.value |
|:----------------|---------:|----------:|----------:|--------:|
| (Intercept)     |   13.521 |     0.186 |    72.873 |   0.000 |
| runtime         |    0.026 |     0.001 |    17.882 |   0.000 |
| actionTRUE      |    0.817 |     0.076 |    10.814 |   0.000 |
| adventureTRUE   |    0.622 |     0.082 |     7.613 |   0.000 |
| animationTRUE   |    1.300 |     0.124 |    10.492 |   0.000 |
| biographyTRUE   |    0.326 |     0.134 |     2.433 |   0.015 |
| comedyTRUE      |    0.287 |     0.073 |     3.917 |   0.000 |
| crimeTRUE       |    0.173 |     0.080 |     2.157 |   0.031 |
| documentaryTRUE |   -1.750 |     0.539 |    -3.246 |   0.001 |
| dramaTRUE       |   -0.247 |     0.071 |    -3.474 |   0.001 |
| familyTRUE      |    0.677 |     0.115 |     5.890 |   0.000 |
| fantasyTRUE     |    0.549 |     0.093 |     5.904 |   0.000 |
| musicalTRUE     |    0.531 |     0.237 |     2.239 |   0.025 |
| mysteryTRUE     |    0.483 |     0.101 |     4.771 |   0.000 |
| romanceTRUE     |    0.285 |     0.084 |     3.388 |   0.001 |
| sci_fiTRUE      |    0.424 |     0.090 |     4.726 |   0.000 |
| sportTRUE       |    0.571 |     0.208 |     2.751 |   0.006 |
| thrillerTRUE    |    0.331 |     0.083 |     3.976 |   0.000 |

The algorithm selected `runtime` and the genre variables of action,
adventure, animation, biography, comedy, crime, documentary, drama,
family, fantasy, musical, mystery, romance, sci-fi, sport, and thriller.
The Bechdel test was not selected as an influential predictor.

In conclusion, based on our data, whether or not a movie passes the
Bechdel test is not a significant predictor of that movie’s potential
for success based on the criteria of profit and budget.

## Scrap Code
