#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // Open the syslog facility
    openlog("writer", LOG_PID|LOG_CONS, LOG_USER);

    // Check if the correct number of arguments are provided
    if (argc != 3) {
        syslog(LOG_ERR, "Invalid number of arguments: expected 2, got %d", argc - 1);
        fprintf(stderr, "Usage: %s <writefile> <writestr>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    const char *writefile = argv[1];
    const char *writestr = argv[2];

    // Try to open the file for writing
    FILE *file = fopen(writefile, "w");
    if (file == NULL) {
        syslog(LOG_ERR, "Error opening file %s: %s", writefile, strerror(errno));
        fprintf(stderr, "Error: Could not open file %s for writing: %s\n", writefile, strerror(errno));
        exit(EXIT_FAILURE);
    }

    // Write the string to the file
    if (fputs(writestr, file) == EOF) {
        syslog(LOG_ERR, "Error writing to file %s: %s", writefile, strerror(errno));
        fprintf(stderr, "Error: Could not write to file %s: %s\n", writefile, strerror(errno));
        fclose(file);
        exit(EXIT_FAILURE);
    }

    // Close the file
    fclose(file);

    // Log the successful write operation
    syslog(LOG_DEBUG, "Writing \"%s\" to %s", writestr, writefile);

    // Close the syslog facility
    closelog();

    return EXIT_SUCCESS;
}

