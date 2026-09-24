cmake_minimum_required(VERSION 3.20)

project(Anura3D LANGUAGES Fortran)

# ---------------------------------------------------------------------------
# Compiler
# ---------------------------------------------------------------------------
#
# Recommended:
#
#   source /opt/intel/oneapi/setvars.sh
#   cmake -S . -B build -DCMAKE_Fortran_COMPILER=ifx
#

set(CMAKE_Fortran_STANDARD 2008)
set(CMAKE_Fortran_STANDARD_REQUIRED OFF)

# ---------------------------------------------------------------------------
# Anura3D source files
# ---------------------------------------------------------------------------

set(ANURA3D_SOURCES
    "src/BuildBJacDet.FOR"
    "src/BuildDElastic.FOR"
    "src/BuildLoad.FOR"
    "src/ElemCalc.FOR"
    "src/ElemCalcQUAD.FOR"
    "src/ElemCalcTETRA.FOR"
    "src/ElemCalcTRI.FOR"
    "src/ElemConnections.FOR"
    "src/GetPrinStress.FOR"
    "src/GetStrain.FOR"
    "src/MeshInfo.FOR"
    "src/RotBoundCond.FOR"
    "src/ReadCalculationData.FOR"
    "src/ReadGeometryData.FOR"
    "src/ReadMaterialData.FOR"
    "src/ReadMPMData.FOR"
    "src/ReadOutputData.FOR"
    "src/Soilmodels/A3DBingham.f"
    "src/Soilmodels/A3DLinearElasticity.f"
    "src/Soilmodels/A3DMohrCoulombStandard.f"
    "src/ExternalSoilModel.for"
    "src/Liquid.FOR"
    "src/AdjustParticleDiscretisation.FOR"
    "src/LagrangianPhase.FOR"
    "src/MPMConstruction.FOR"
    "src/MPMConvPhase.FOR"
    "src/MPMData.FOR"
    "src/MPMDYN2PhaseSP.FOR"
    "src/MPMDYN3PhaseSP.FOR"
    "src/MPMDynamicExplicit.FOR"
    "src/MPMDYNBTSig.FOR"
    "src/MPMDynContact.FOR"
    "src/MPMDYNConvPhase.FOR"
    "src/MPMDYNStresses.FOR"
    "src/MPMDynViscousBoundary.FOR"
    "src/MPMEmptyElements.FOR"
    "src/MPMExcavation.FOR"
    "src/MPMInit.FOR"
    "src/MPMMeshAdjustment.FOR"
    "src/MPMStrainSmoothing.FOR"
    "src/MPMStresses.FOR"
    "src/Particle.FOR"
    "src/RigidBody.f"
    "src/TwoLayerFormulation.FOR"
    "src/gidpost.F90"
    "src/WriteMPMData.FOR"
    "src/WriteNodalData.FOR"
    "src/WriteOutPut_GiD.for"
    "src/WriteResultData.FOR"
    "src/WriteTestData.FOR"
    "src/WriteVTK2Layer.FOR"
    "src/WriteVTKASCII.FOR"
    "src/WriteVTKBinary.FOR"
    "src/WriteVTKOutput.FOR"
    "src/Counters.FOR"
    "src/ErrorHandler.for"
    "src/Feedback.for"
    "src/FileIO.for"
    "src/GeoMath.FOR"
    "src/getversion.for"
    "src/GlobalConstants.FOR"
    "src/InitialiseElementType.for"
    "src/InitialiseKernel.FOR"
    "src/ISORT.FOR"
    "src/MatrixMath.FOR"
    "src/String.for"
    "src/timing.for"
    "src/Solver/mkl_dss.f90"
    "src/Solver/Solver.FOR"
    "src/Anura3D.for"
    "src/Kernel.for"
)

add_executable(Anura3D ${ANURA3D_SOURCES})

# ---------------------------------------------------------------------------
# Intel oneAPI / MKL
# ---------------------------------------------------------------------------
#
# These options correspond to the relevant compiler settings used by
# the existing Intel Visual Studio project.
#

if(CMAKE_Fortran_COMPILER_ID MATCHES "IntelLLVM|Intel")

    target_compile_options(Anura3D PRIVATE
        -fpp
        -free
        -assume buffered_io
        -reentrancy threaded
        -real-size 64
        -auto
        -fp-model strict
        -fpe0
        -qmkl=sequential
    )

endif()

# ---------------------------------------------------------------------------
# External dependencies
# ---------------------------------------------------------------------------
#
# These libraries are NOT built by this repository.
#
# Required:
#   - HDF5 with Fortran support
#   - zlib
#   - GiDPost
#

find_package(HDF5 REQUIRED COMPONENTS Fortran)
find_package(ZLIB REQUIRED)

find_library(
    GIDPOST_LIBRARY
    NAMES gidpost
    REQUIRED
)

target_include_directories(Anura3D PRIVATE
    ${HDF5_INCLUDE_DIRS}
)

target_link_libraries(Anura3D PRIVATE
    ${HDF5_Fortran_LIBRARIES}
    ZLIB::ZLIB
    ${GIDPOST_LIBRARY}
)
