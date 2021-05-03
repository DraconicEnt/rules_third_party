#include <zlib.h>

int main(int argc, char* argv[])
{
    z_stream stream;

    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    return deflateInit(&stream, Z_DEFAULT_COMPRESSION);
}
