// kernel.c
void main() {
    const char *str = "Hello, World!";
    char *video_memory = (char *) 0xb8000; // VGA text mode buffer
    int i;

    // Write string to video memory
    for (i = 0; str[i] != '\0'; i++) {
        video_memory[i * 2] = str[i];      // Character
        video_memory[i * 2 + 1] = 0x07;    // Attribute (light gray on black)
    }

    // Infinite loop to keep the kernel running
    while (1) {}
}
