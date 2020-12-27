#include <enet/enet.h>

int main(int argc, char* argv[])
{
    if (enet_initialize () != 0)
    {
        exit (EXIT_FAILURE);
    }

    return 0;
}
