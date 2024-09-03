
obj/p-allocator.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main()>:

// These global variables go on the data page.
uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main() {
  100000:	f3 0f 1e fa          	endbr64 
// make_syscall
//    These functions define the WeensyOS system call calling convention.
//    We provide versions for system calls with 0-2 arguments.

inline uintptr_t make_syscall(int syscallno) {
    register uintptr_t rax asm("rax") = syscallno;
  100004:	b8 01 00 00 00       	mov    $0x1,%eax
    asm volatile ("syscall"
  100009:	0f 05                	syscall 
    return x - (x % multiple);
}
template <typename T>
inline constexpr T round_up(T x, unsigned multiple) {
    static_assert(std::is_unsigned<T>::value, "T must be unsigned");
    return round_down(x + multiple - 1, multiple);
  10000b:	b8 0f 20 10 00       	mov    $0x10200f,%eax
    pid_t p = sys_getpid();

    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = (uint8_t*) round_up((uintptr_t) end, PAGESIZE);
  100010:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100016:	48 89 05 eb 0f 00 00 	mov    %rax,0xfeb(%rip)        # 101008 <heap_top>
    return x;
}

__always_inline uintptr_t rdrsp() {
    uintptr_t x;
    asm volatile("movq %%rsp, %0" : "=r" (x));
  10001d:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = (uint8_t*) round_down((uintptr_t) rdrsp() - 1, PAGESIZE);
  100020:	48 83 e8 01          	sub    $0x1,%rax
  100024:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002a:	48 89 05 cf 0f 00 00 	mov    %rax,0xfcf(%rip)        # 101000 <stack_bottom>
    register uintptr_t rax asm("rax") = syscallno;
  100031:	b8 02 00 00 00       	mov    $0x2,%eax
    asm volatile ("syscall"
  100036:	0f 05                	syscall 
            : "+a" (rax)
            : /* all input registers are also output registers */
            : "cc", "memory", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
              "r10", "r11");
    return rax;
  100038:	eb f7                	jmp    100031 <process_main()+0x31>
