/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef SCALE_OUTCOME_OUTCOME
#define SCALE_OUTCOME_OUTCOME

#pragma warning(push)
#pragma warning(disable:4583)
#pragma warning(disable:4582)
#include <boost/outcome/outcome.hpp>
#include <boost/outcome/try.hpp>
#pragma warning(pop)

#include "outcome-register.hpp"

namespace scale::outcome {

using namespace BOOST_OUTCOME_V2_NAMESPACE;

template <class R, class S = std::error_code,
          class NoValuePolicy = policy::default_policy<R, S, void>>
using result = basic_result<R, S, NoValuePolicy>;

} // namespace scale::outcome

// Starting from commit d33e73cf2f643f73930518cb253bf80efbca70a4 in version 1.76
// Boost Outcome doesn't add `auto&&` to a variable automatically. So we need to do it
// manually for backward-compatitbility.
#if BOOST_VERSION < 107600
#define OUTCOME_TRY(...) BOOST_OUTCOME_TRY(__VA_ARGS__)
#else
#define OUTCOME_TRY_1(x) BOOST_OUTCOME_TRY(x)
#define OUTCOME_TRY_2(x, y) BOOST_OUTCOME_TRY(auto&& x, y)
#define _GET_OUTCOME_MACRO(_1, _2, NAME, ...) NAME
#define OUTCOME_TRY(... ) _GET_OUTCOME_MACRO(__VA_ARGS__, OUTCOME_TRY_2, OUTCOME_TRY_1)(__VA_ARGS__)
#endif // BOOST_VERSION < 107600

#endif // SCALE_OUTCOME_OUTCOME
