
obj/p-allocator3.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000180000 <process_main()>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main() {
  180000:	f3 0f 1e fa          	endbr64 
// make_syscall
//    These functions define the WeensyOS system call calling convention.
//    We provide versions for system calls with 0-2 arguments.

inline uintptr_t make_syscall(int syscallno) {
    register uintptr_t rax asm("rax") = syscallno;
  180004:	b8 01 00 00 00       	mov    $0x1,%eax
    asm volatile ("syscall"
  180009:	0f 05                	syscall 
    return x - (x % multiple);
}
template <typename T>
inline constexpr T round_up(T x, unsigned multiple) {
    static_assert(std::is_unsigned<T>::value, "T must be unsigned");
    return round_down(x + multiple - 1, multiple);
  18000b:	b8 0f 20 18 00       	mov    $0x18200f,%eax
    pid_t p = sys_getpid();

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = (uint8_t*) round_up((uintptr_t) end, PAGESIZE);
  180010:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  180016:	48 89 05 eb 0f 00 00 	mov    %rax,0xfeb(%rip)        # 181008 <heap_top>
    return x;
}

__always_inline uintptr_t rdrsp() {
    uintptr_t x;
    asm volatile("movq %%rsp, %0" : "=r" (x));
  18001d:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = (uint8_t*) round_down((uintptr_t) rdrsp() - 1, PAGESIZE);
  180020:	48 83 e8 01          	sub    $0x1,%rax
  180024:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  18002a:	48 89 05 cf 0f 00 00 	mov    %rax,0xfcf(%rip)        # 181000 <stack_bottom>
    register uintptr_t rax asm("rax") = syscallno;
  180031:	b8 02 00 00 00       	mov    $0x2,%eax
    asm volatile ("syscall"
  180036:	0f 05                	syscall 
            : "+a" (rax)
            : /* all input registers are also output registers */
            : "cc", "memory", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
              "r10", "r11");
    return rax;
  180038:	eb f7                	jmp    180031 <process_main()+0x31>
