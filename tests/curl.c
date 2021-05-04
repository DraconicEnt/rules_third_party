#include <curl/curl.h>

int main(int argc, char* argv[])
{
    CURL* curl = curl_easy_init();

    if (curl)
    {
        return 0;
    }
    return 1;
}
