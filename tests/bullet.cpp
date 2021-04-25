#include <bullet/btBulletDynamicsCommon.h>

int main(int argc, char* argv[])
{
    btDefaultCollisionConfiguration* collisionConfiguration = new btDefaultCollisionConfiguration();
	
	if (collisionConfiguration)
	{	
		return 0;
	}
	return 1;
}
