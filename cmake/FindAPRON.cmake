#*******************************************************************************
#
# Find APRON library.
#
# Author: Maxime Arthaud
#
# Contact: ikos@lists.nasa.gov
#
# Notices:
#
# Copyright (c) 2011-2018 United States Government as represented by the
# Administrator of the National Aeronautics and Space Administration.
# All Rights Reserved.
#
# Disclaimers:
#
# No Warranty: THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF
# ANY KIND, EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED
# TO, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL CONFORM TO SPECIFICATIONS,
# ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
# OR FREEDOM FROM INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE
# ERROR FREE, OR ANY WARRANTY THAT DOCUMENTATION, IF PROVIDED, WILL CONFORM TO
# THE SUBJECT SOFTWARE. THIS AGREEMENT DOES NOT, IN ANY MANNER, CONSTITUTE AN
# ENDORSEMENT BY GOVERNMENT AGENCY OR ANY PRIOR RECIPIENT OF ANY RESULTS,
# RESULTING DESIGNS, HARDWARE, SOFTWARE PRODUCTS OR ANY OTHER APPLICATIONS
# RESULTING FROM USE OF THE SUBJECT SOFTWARE.  FURTHER, GOVERNMENT AGENCY
# DISCLAIMS ALL WARRANTIES AND LIABILITIES REGARDING THIRD-PARTY SOFTWARE,
# IF PRESENT IN THE ORIGINAL SOFTWARE, AND DISTRIBUTES IT "AS IS."
#
# Waiver and Indemnity:  RECIPIENT AGREES TO WAIVE ANY AND ALL CLAIMS AGAINST
# THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL
# AS ANY PRIOR RECIPIENT.  IF RECIPIENT'S USE OF THE SUBJECT SOFTWARE RESULTS
# IN ANY LIABILITIES, DEMANDS, DAMAGES, EXPENSES OR LOSSES ARISING FROM SUCH
# USE, INCLUDING ANY DAMAGES FROM PRODUCTS BASED ON, OR RESULTING FROM,
# RECIPIENT'S USE OF THE SUBJECT SOFTWARE, RECIPIENT SHALL INDEMNIFY AND HOLD
# HARMLESS THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS,
# AS WELL AS ANY PRIOR RECIPIENT, TO THE EXTENT PERMITTED BY LAW.
# RECIPIENT'S SOLE REMEDY FOR ANY SUCH MATTER SHALL BE THE IMMEDIATE,
# UNILATERAL TERMINATION OF THIS AGREEMENT.
#
#*****************************************************************************/

if (NOT APRON_FOUND)
  set(APRON_ROOT "" CACHE PATH "Path to apron install directory.")

  set(APRON_INCLUDE_SEARCH_DIRS "")
  set(APRON_LIBRARY_SEARCH_DIRS "")

  if (APRON_ROOT)
    list(APPEND APRON_INCLUDE_SEARCH_DIRS "${APRON_ROOT}/include")
    list(APPEND APRON_LIBRARY_SEARCH_DIRS "${APRON_ROOT}/lib")
  endif()
  if (DEFINED ENV{APRON_INSTALL})
    list(APPEND APRON_INCLUDE_SEARCH_DIRS "$ENV{APRON_INSTALL}/include")
    list(APPEND APRON_LIBRARY_SEARCH_DIRS "$ENV{APRON_INSTALL}/lib")
  endif()

  find_package(GMP)
  find_package(MPFR)
  find_package(PPL)

  find_path(APRON_INCLUDE_DIR
    NAMES ap_abstract0.h
    HINTS ${APRON_INCLUDE_SEARCH_DIRS}
  )

  find_library(APRON_APRON_LIB
    NAMES apron
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  find_library(APRON_BOX_LIB
    NAMES boxMPQ
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  find_library(APRON_OCT_LIB
    NAMES octMPQ
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  find_library(APRON_POLKA_LIB
    NAMES polkaMPQ
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  find_library(APRON_PPL_LIB
    NAMES ap_ppl
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  find_library(APRON_PKGRID_LIB
    NAMES ap_pkgrid
    HINTS ${APRON_LIBRARY_SEARCH_DIRS}
  )

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(APRON
    REQUIRED_VARS
      APRON_INCLUDE_DIR APRON_APRON_LIB APRON_BOX_LIB APRON_OCT_LIB
      APRON_POLKA_LIB APRON_PPL_LIB APRON_PKGRID_LIB
      GMP_FOUND MPFR_FOUND PPL_FOUND
    FAIL_MESSAGE
      "Could NOT find APRON. Please provide -DAPRON_ROOT=<apron-directory>")

  set(APRON_INCLUDE_DIR
    ${APRON_INCLUDE_DIR}
    ${GMP_INCLUDE_DIR}
    ${GMPXX_INCLUDE_DIR}
    ${MPFR_INCLUDE_DIR}
    ${PPL_INCLUDE_DIR})

  set(APRON_LIBRARIES
    ${APRON_APRON_LIB}
    ${APRON_BOX_LIB}
    ${APRON_OCT_LIB}
    ${APRON_POLKA_LIB}
    ${APRON_PPL_LIB}
    ${APRON_PKGRID_LIB}
    ${GMP_LIB}
    ${GMPXX_LIB}
    ${MPFR_LIB}
    ${PPL_LIB})

  mark_as_advanced(
    APRON_INCLUDE_DIR
    APRON_APRON_LIB
    APRON_BOX_LIB
    APRON_OCT_LIB
    APRON_POLKA_LIB
    APRON_PPL_LIB
    APRON_PKGRID_LIB
    APRON_LIBRARIES)
endif()
