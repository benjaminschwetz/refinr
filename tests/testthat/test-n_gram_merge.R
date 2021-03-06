context("n_gram_merge")

vect <- c("Acmme Pizza, Inc.", "ACME PIZA COMPANY", "Acme Pizzazza LLC",
          "acme pizza limited", "Tom's Sports Equipment, Inc.",
          "toms sports equipment")
vect_ng <- n_gram_merge(vect)

test_that("output is a char vector", expect_is(vect_ng, "character"))

test_that("output lengths are correct", {
  expect_equal(length(vect_ng), length(vect))
  expect_equal(length(unique(vect_ng)), 2)
  expect_equal(length(unique(n_gram_merge(vect, numgram = 3))), 5)
  expect_equal(length(unique(n_gram_merge(vect, edit_threshold = 5))), 2)
  expect_equal(length(unique(n_gram_merge(vect, bus_suffix = FALSE))),
               length(vect))
  vect_ng <- n_gram_merge(
    vect, edit_dist_weights = c(d = 1, i = 1, s = 0.1, t = 0.1))
  expect_equal(length(unique(vect_ng)), 4)
})

test_that("param 'edit_threshold' set to NA having expected effect", {
  expect_equal(length(unique(n_gram_merge(vect, edit_threshold = NA))), 5)
})

vect <- c("Bakersfield Highschool", "BAKERSFIELD high", "high school, bakersfield")
vect_ng <- n_gram_merge(vect, ignore_strings = c("high", "school", "highschool"))
test_that("param 'ignore_strings' having expected effect", {
  expect_equal(unique(vect_ng), vect[2])
})
