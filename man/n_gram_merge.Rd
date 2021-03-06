% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/n_gram_merge.R
\name{n_gram_merge}
\alias{n_gram_merge}
\title{Value merging based on ngram fingerprints}
\usage{
n_gram_merge(vect, numgram = 2, edit_threshold = 1,
  edit_dist_weights = c(d = 0.33, i = 0.33, s = 1, t = 0.5),
  bus_suffix = TRUE, ignore_strings = NULL)
}
\arguments{
\item{vect}{Character vector of items for which you want similar values
merged.}

\item{numgram}{Numeric value indicating the number of characters that
will occupy each token. Default value is 2. This parameter gets passed
along to the function \code{\link[ngram]{ngram}}.}

\item{edit_threshold}{Numeric value indicating the threshold at which a
merge is performed, based on the sum of the edit values derived from
param \code{edit_dist_weights}. Default value is 1. If this parameter is
set to 0 or NA, then no approximate string matching will be done, and all
merging will be based on strings that have identical ngram fingerprints.}

\item{edit_dist_weights}{Numeric vector indicating the weights to assign to
the four edit operations (see details below), for the purpose of
approximate string matching. Default values are
c(d = 0.33, i = 0.33, s = 1, t = 0.5). This parameter gets passed along
to the function \code{\link[stringdist]{stringdistmatrix}}. Must be either
a numeric vector of length four, or NA.}

\item{bus_suffix}{Logical indicating whether the merging of records should
be insensitive to common business suffixes (TRUE) or not (FALSE). If
input \code{vect} a vector of business names it's recommended to set this
to TRUE. Default value is TRUE.}

\item{ignore_strings}{Character vector, these strings will be ignored during
the merging of values within \code{vect}. Default value is NULL.}
}
\value{
Character vector with similar values merged.
}
\description{
This function takes a character vector and makes edits and merges values
that are approximately equivalent yet not identical. It uses a two step
process, the first is clustering values based on their ngram fingerprint
method, described here
\url{https://github.com/OpenRefine/OpenRefine/wiki/Clustering-In-Depth}.
The second step is merging values based on approximate string matching of
the ngram fingerprints, using the \code{\link[stringdist]{stringdistmatrix}}
function from the package \code{\link{stringdist}}.
}
\details{
Parameter \code{edit_dist_weights} are edit distance values that
 get passed to the approximate string matching function
 \code{\link[stringdist]{stringdistmatrix}}. The param takes four arguments,
 each one is a specific type of edit, with default penalty value.
 \itemize{
 \item d: Deletion, default value is 0.33
 \item i: Insertion, default value is 0.33
 \item s: substitution, default value is 1
 \item t: transposition, default value is 0.5
 }

 For parameter \code{numgram}, the function is unreliable for any values
 other than 2.
}
\examples{
# The performance of the approximate string matching can be ajusted using
# parameter 'edit_dist_weights'.
x <- c("Acmme Pizza, Inc.",
       "ACME PIZA COMPANY",
       "Acme Pizzazza LLC")

n_gram_merge(vect = x,
             numgram = 2,
             edit_threshold = 1,
             edit_dist_weights = c(d = 0.2, i = 1, s = 1, t = 1))

n_gram_merge(vect = x,
             numgram = 2,
             edit_threshold = 1,
             edit_dist_weights = c(d = 1, i = 0.2, s = 1, t = 1))

n_gram_merge(vect = x,
             numgram = 2,
             edit_threshold = 1,
             edit_dist_weights = c(d = 0.2, i = 0.2, s = 1, t = 1))

# Use parameter 'ignore_strings' to ignore specific strings during merging
# of values.
x <- c("Bakersfield Highschool",
       "BAKERSFIELD high",
       "high school, bakersfield")
n_gram_merge(x, ignore_strings = c("high", "school", "highschool"))

}
