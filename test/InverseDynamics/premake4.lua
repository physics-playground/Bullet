
	project "Test_InverseDynamicsKinematics"

	kind "ConsoleApp"

--	defines {  }



	includedirs
	{
		".",
		"../../src",
		"../../examples/InverseDynamics",
		"../../extras/InverseDynamics",
		"../gtest-1.7.0/include"

	}


	if os.istarget("Windows") then
		--see http://stackoverflow.com/questions/12558327/google-test-in-visual-studio-2012
		defines {"_VARIADIC_MAX=10"}
	end

	links {"BulletInverseDynamicsUtils", "BulletInverseDynamics","Bullet3Common","LinearMath", "gtest"}

	files {
		"test_invdyn_kinematics.cpp",
	}

	if os.istarget("Linux") then
                links {"pthread"}
        end





        project "Test_InverseDynamicsJacobian"


        kind "ConsoleApp"

--      defines {  }



        includedirs
        {
                ".",
                "../../src",
                "../../examples/InverseDynamics",
                "../../extras/InverseDynamics",
                "../gtest-1.7.0/include"

        }


        if os.istarget("Windows") then
                --see http://stackoverflow.com/questions/12558327/google-test-in-visual-studio-2012
                defines {"_VARIADIC_MAX=10"}
        end

        links {"BulletInverseDynamicsUtils", "BulletInverseDynamics","Bullet3Common","LinearMath", "gtest"}

        files {
                "test_invdyn_jacobian.cpp",
        }

        if os.istarget("Linux") then
                links {"pthread"}
        end

	project "Test_InverseForwardDynamics"
	kind "ConsoleApp"
--      defines {  }



        includedirs
        {
                ".",
                "../../src",
                "../../examples/InverseDynamics",
                "../../examples/ThirdPartyLibs",
                "../../extras/InverseDynamics",
                "../gtest-1.7.0/include",
                "../../examples/ThirdPartyLibs",
        }


        if os.istarget("Windows") then
                --see http://stackoverflow.com/questions/12558327/google-test-in-visual-studio-2012
                defines {"_VARIADIC_MAX=10"}
        end

        links {"BulletDynamics", "BulletCollision","BulletInverseDynamicsUtils", "BulletInverseDynamics","Bullet3Common","LinearMath", "gtest"}

        files {
                "test_invdyn_bullet.cpp",
       		"../../examples/Utils/b3ResourcePath.cpp",
			 "../../examples/Importers/ImportURDFDemo/ConvertRigidBodies2MultiBody.h",
        "../../examples/Importers/ImportURDFDemo/MultiBodyCreationInterface.h",
        "../../examples/Importers/ImportURDFDemo/MyMultiBodyCreator.cpp",
        "../../examples/Importers/ImportURDFDemo/MyMultiBodyCreator.h",
        "../../examples/Importers/ImportURDFDemo/BulletUrdfImporter.cpp",
        "../../examples/Importers/ImportURDFDemo/BulletUrdfImporter.h",
        "../../examples/Importers/ImportURDFDemo/urdfStringSplit.cpp",
        "../../examples/Importers/ImportURDFDemo/UrdfParser.cpp",
        "../../examples/Importers/ImportURDFDemo/UrdfParser.h",
        "../../examples/Importers/ImportURDFDemo/URDF2Bullet.cpp",
        "../../examples/Importers/ImportURDFDemo/URDF2Bullet.h",
	"../../examples/Importers/ImportMeshUtility/b3ImportMeshUtility.cpp",
        "../../examples/ThirdPartyLibs/stb_image/stb_image.cpp",
        "../../examples/Utils/b3Clock.cpp",
        "../../extras/Serialize/BulletWorldImporter/*",
        "../../extras/Serialize/BulletFileLoader/*",
        "../../examples/Importers/ImportURDFDemo/URDFImporterInterface.h",
        "../../examples/Importers/ImportURDFDemo/URDFJointTypes.h",
        "../../examples/Importers/ImportObjDemo/Wavefront2GLInstanceGraphicsShape.cpp",
        "../../examples/Importers/ImportObjDemo/LoadMeshFromObj.cpp",
        "../../examples/Importers/ImportSTLDemo/ImportSTLSetup.h",
        "../../examples/Importers/ImportSTLDemo/LoadMeshFromSTL.h",
        "../../examples/Importers/ImportColladaDemo/LoadMeshFromCollada.cpp",
        "../../examples/Importers/ImportColladaDemo/ColladaGraphicsInstance.h",
        "../../examples/ThirdPartyLibs/Wavefront/tiny_obj_loader.cpp",
    "../../examples/ThirdPartyLibs/tinyxml2/tinyxml2.cpp",
    "../../examples/ThirdPartyLibs/urdf/boost_replacement/lexical_cast.h",

	}

        if os.istarget("Linux") then
                links {"pthread"}
        end

