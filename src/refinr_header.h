#include <Rcpp.h>
using namespace Rcpp;
LogicalVector equality(CharacterVector lookupvect, String charstring);
String most_freq(String clust, CharacterVector keyssub, CharacterVector vectsub);
LogicalVector cpp_in(CharacterVector x, CharacterVector y);
