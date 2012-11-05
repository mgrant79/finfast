#include "ruby.h"
#include "math.h"
#include "stdio.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

void Init_finfast();
static VALUE method_newton(VALUE self, VALUE pmts, VALUE exps, 
			   VALUE guess, VALUE tolerance, VALUE max_iter);
static long double fx(long double x, VALUE *pmts, VALUE *exps, long len);
static long double dfx(long double x, VALUE *pmts, VALUE *exps, long len);
static long double const lower_bound = -0.99;

void Init_finfast() {
  VALUE module = rb_define_module("Finfast");
  rb_define_method(module, "newton", method_newton, 5);
}

static long double fx(long double x, VALUE *pmts, VALUE *exps, long len)
{
  long double result = 0.0;
  int i;
  for (i = 0; i < len; ++i) {
    long double ex = -NUM2DBL(exps[i]);
    long double pmt = NUM2DBL(pmts[i]);
    //printf("Payment: %Lf, exponent: %Lf\n", pmt, ex);
    result += (pmt * pow(1.0 + x, ex));
  }
  return result;
}

static long double dfx(long double x, VALUE *pmts, VALUE *exps, long len)
{
  long double result = 0.0;
  int i;
  for (i = 0; i < len; ++i) {
    long double ex = -NUM2DBL(exps[i]);
    long double pmt = NUM2DBL(pmts[i]);
    result += (pmt * ex * pow(1.0 + x, ex - 1.0));
  }
  return result;
}

static VALUE method_newton(VALUE self, VALUE pmts, VALUE exps, 
			   VALUE guess, VALUE tolerance, VALUE max_iter) {
  long len = RARRAY_LEN(pmts);
  long max_i = NUM2INT(max_iter);
  long double x0 = NUM2DBL(guess);
  long double x1 = 0.0;
  long double tol = NUM2DBL(tolerance);
  long double err = 1e100;
  VALUE *pmt_p = RARRAY_PTR(pmts);
  VALUE *exp_p = RARRAY_PTR(exps);
  long iter = 0;

  while (err > tol && iter++ < max_i) {
    x1 = x0 - (fx(x0, pmt_p, exp_p, len) / dfx(x0, pmt_p, exp_p, len));
    err = fabs(x1 - x0);
    x0 =  MAX(x1, lower_bound);
  }

  return (err > tol) ? Qnil : rb_float_new(x0);
}
