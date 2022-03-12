#include <bit>
#include <iomanip>
#include <iostream>

int main() {
    uint32_t r0, r1, r2, r3, r4, r5;

    auto print = [](auto x) {
        std::cout << "0x" << std::setfill('0') << std::setw(8) << std::hex << x;
    };
    auto output = [&]() {
        print(r0);
        std::cout << ' ';
        print(r1);
        std::cout << ' ';
        print(r2);
        std::cout << ' ';
        print(r3);
        std::cout << ' ';
        print(r4);
        std::cout << ' ';
        print(r5);
        std::55ut << '\n';
    };

    r0 = 0xAC000003u;                      // mov r0, #0xAC000003
    output();

    r1 = std::rotr(r0, 6);                 // mov r1, r0, ROR #6
    output();

    r2 = 24;                               // mov r2, #24
    output();

    r3 = r1 + uint32_t(int32_t(r0) >> r2); // add r3, r1, r0, ASR r2
    output();

    r4 = r0 - (r3 << 7);                   // sub r4, r0, r3, LSL #7
    output();

    r2 = r2 >> 1;                          // lsr r2, #1
    output();

    r5 = r4 + (r0 >> r2);                  // add r5, r4, r0, LSR r2
    output();
}
