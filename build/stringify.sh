#!/bin/sh

unamestr="$(uname)"

if [ "$unamestr" = 'Linux' ]; then
    echo "Using Linux"
else
    echo "Assuming Mac OSX"
fi

premake() {
    if [ "$(uname)" = 'Linux' ]; then
        mypremake="./premake4_linux64"
    else
        mypremake="./premake4_osx"
    fi
    $mypremake --file=stringifyKernel.lua "$@" stringify
}

premake --kernelfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/RadixSort32Kernels.cl" --headerfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/RadixSort32KernelsCL.h" --stringname="radixSort32KernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/BoundSearchKernels.cl" --headerfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/BoundSearchKernelsCL.h" --stringname="boundSearchKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/PrefixScanKernels.cl" --headerfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/PrefixScanKernelsCL.h" --stringname="prefixScanKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/PrefixScanFloat4Kernels.cl" --headerfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/PrefixScanKernelsFloat4CL.h" --stringname="prefixScanKernelsFloat4CL"

premake --kernelfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/FillKernels.cl" --headerfile="../src/Bullet3OpenCL/ParallelPrimitives/kernels/FillKernelsCL.h" --stringname="fillKernelsCL"

premake --kernelfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/sap.cl" --headerfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/sapKernels.h" --stringname="sapCL"

premake --kernelfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/gridBroadphase.cl" --headerfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/gridBroadphaseKernels.h" --stringname="gridBroadphaseCL"
premake --kernelfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/parallelLinearBvh.cl" --headerfile="../src/Bullet3OpenCL/BroadphaseCollision/kernels/parallelLinearBvhKernels.h" --stringname="parallelLinearBvhCL"

premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/sat.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/satKernels.h" --stringname="satKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/satConcave.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/satConcaveKernels.h" --stringname="satConcaveKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/mpr.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/mprKernels.h" --stringname="mprKernelsCL"

premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/satClipHullContacts.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/satClipHullContacts.h" --stringname="satClipKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/primitiveContacts.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/primitiveContacts.h" --stringname="primitiveContactsKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/bvhTraversal.cl" --headerfile="../src/Bullet3OpenCL/NarrowphaseCollision/kernels/bvhTraversal.h" --stringname="bvhTraversalKernelCL"

premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/integrateKernel.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/integrateKernel.h" --stringname="integrateKernelCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/updateAabbsKernel.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/updateAabbsKernel.h" --stringname="updateAabbsKernelCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/solverSetup.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/solverSetup.h" --stringname="solverSetupCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/solverSetup2.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/solverSetup2.h" --stringname="solverSetup2CL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/batchingKernels.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/batchingKernels.h" --stringname="batchingKernelsCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/batchingKernelsNew.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/batchingKernelsNew.h" --stringname="batchingKernelsNewCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/solverUtils.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/solverUtils.h" --stringname="solverUtilsCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/solveContact.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/solveContact.h" --stringname="solveContactCL"
premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/solveFriction.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/solveFriction.h" --stringname="solveFrictionCL"

premake --kernelfile="../src/Bullet3OpenCL/RigidBody/kernels/jointSolver.cl" --headerfile="../src/Bullet3OpenCL/RigidBody/kernels/jointSolver.h" --stringname="solveConstraintRowsCL"

premake --kernelfile="../src/Bullet3OpenCL/Raycast/kernels/rayCastKernels.cl" --headerfile="../src/Bullet3OpenCL/Raycast/kernels/rayCastKernels.h" --stringname="rayCastKernelCL"

premake --kernelfile="../examples/OpenGLWindow/Shaders/instancingVS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/instancingVS.h" --stringname="instancingVertexShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/instancingPS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/instancingPS.h" --stringname="instancingFragmentShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/pointSpriteVS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/pointSpriteVS.h" --stringname="pointSpriteVertexShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/pointSpritePS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/pointSpritePS.h" --stringname="pointSpriteFragmentShader"

premake --kernelfile="../examples/OpenGLWindow/Shaders/createShadowMapInstancingPS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/createShadowMapInstancingPS.h" --stringname="createShadowMapInstancingFragmentShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/createShadowMapInstancingVS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/createShadowMapInstancingVS.h" --stringname="createShadowMapInstancingVertexShader"

premake --kernelfile="../examples/OpenGLWindow/Shaders/useShadowMapInstancingPS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/useShadowMapInstancingPS.h" --stringname="useShadowMapInstancingFragmentShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/useShadowMapInstancingVS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/useShadowMapInstancingVS.h" --stringname="useShadowMapInstancingVertexShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/projectiveTextureInstancingPS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/projectiveTextureInstancingPS.h" --stringname="projectiveTextureInstancingFragmentShader"
premake --kernelfile="../examples/OpenGLWindow/Shaders/projectiveTextureInstancingVS.glsl" --headerfile="../examples/OpenGLWindow/Shaders/projectiveTextureInstancingVS.h" --stringname="projectiveTextureInstancingVertexShader"
premake --kernelfile="../examples/OpenCL/broadphase/pairsKernel.cl" --headerfile="../examples/OpenCL/broadphase/pairsKernel.h" --stringname="pairsKernelsCL"
