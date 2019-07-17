// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// multipleFamilyPValue_cpp
double multipleFamilyPValue_cpp(const Rcpp::NumericVector& sharingProbs, const Rcpp::LogicalVector& observedSharing, double minPValue);
RcppExport SEXP _RVS_multipleFamilyPValue_cpp(SEXP sharingProbsSEXP, SEXP observedSharingSEXP, SEXP minPValueSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Rcpp::NumericVector& >::type sharingProbs(sharingProbsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::LogicalVector& >::type observedSharing(observedSharingSEXP);
    Rcpp::traits::input_parameter< double >::type minPValue(minPValueSEXP);
    rcpp_result_gen = Rcpp::wrap(multipleFamilyPValue_cpp(sharingProbs, observedSharing, minPValue));
    return rcpp_result_gen;
END_RCPP
}
// multipleVariantPValue_cpp
Rcpp::List multipleVariantPValue_cpp(const Rcpp::IntegerMatrix& alleles, const Rcpp::CharacterVector& variants, const Rcpp::CharacterVector& famIds, const Rcpp::NumericVector& sharingProbs, const Rcpp::Nullable<Rcpp::CharacterVector>& rfilter, const Rcpp::NumericVector& minorAllele, double alpha);
RcppExport SEXP _RVS_multipleVariantPValue_cpp(SEXP allelesSEXP, SEXP variantsSEXP, SEXP famIdsSEXP, SEXP sharingProbsSEXP, SEXP rfilterSEXP, SEXP minorAlleleSEXP, SEXP alphaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Rcpp::IntegerMatrix& >::type alleles(allelesSEXP);
    Rcpp::traits::input_parameter< const Rcpp::CharacterVector& >::type variants(variantsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::CharacterVector& >::type famIds(famIdsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::NumericVector& >::type sharingProbs(sharingProbsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::Nullable<Rcpp::CharacterVector>& >::type rfilter(rfilterSEXP);
    Rcpp::traits::input_parameter< const Rcpp::NumericVector& >::type minorAllele(minorAlleleSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    rcpp_result_gen = Rcpp::wrap(multipleVariantPValue_cpp(alleles, variants, famIds, sharingProbs, rfilter, minorAllele, alpha));
    return rcpp_result_gen;
END_RCPP
}
// enrichmentPValue_cpp
double enrichmentPValue_cpp(const Rcpp::IntegerMatrix& snpMat, const Rcpp::CharacterVector& famIds, const Rcpp::NumericVector& sharingProbs, const Rcpp::NumericVector& minorAllele, double threshold);
RcppExport SEXP _RVS_enrichmentPValue_cpp(SEXP snpMatSEXP, SEXP famIdsSEXP, SEXP sharingProbsSEXP, SEXP minorAlleleSEXP, SEXP thresholdSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const Rcpp::IntegerMatrix& >::type snpMat(snpMatSEXP);
    Rcpp::traits::input_parameter< const Rcpp::CharacterVector& >::type famIds(famIdsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::NumericVector& >::type sharingProbs(sharingProbsSEXP);
    Rcpp::traits::input_parameter< const Rcpp::NumericVector& >::type minorAllele(minorAlleleSEXP);
    Rcpp::traits::input_parameter< double >::type threshold(thresholdSEXP);
    rcpp_result_gen = Rcpp::wrap(enrichmentPValue_cpp(snpMat, famIds, sharingProbs, minorAllele, threshold));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_RVS_multipleFamilyPValue_cpp", (DL_FUNC) &_RVS_multipleFamilyPValue_cpp, 3},
    {"_RVS_multipleVariantPValue_cpp", (DL_FUNC) &_RVS_multipleVariantPValue_cpp, 7},
    {"_RVS_enrichmentPValue_cpp", (DL_FUNC) &_RVS_enrichmentPValue_cpp, 5},
    {NULL, NULL, 0}
};

RcppExport void R_init_RVS(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}