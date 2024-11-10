---
id: x86_calling_conventions
aliases: []
tags:
  - assembly
  - program
  - execution_flow
  - registers
---
> [!NOTE]
> Windows x64 calling convention uses RCX, RDX, R8, and R9 for the first four integer or pointer arguments, with additional arguments passed on the stack. The return value is placed in RAX.

# Unix
## The Caller’s Rules
>The caller should adhere to the following rules when invoking a subroutine:
1. Before calling a subroutine, the caller should save the contents of certain registers that are designated
caller-saved. The caller-saved registers are r10, r11, and any registers that parameters are put into. If
you want the contents of these registers to be preserved across the subroutine call, push them onto
the stack.
2. To pass parameters to the subroutine, we put up to six of them into registers <mark>***(in order: rdi, rsi,
rdx, rcx, r8, r9).***<> If there are more than six parameters to the subroutine, then push the rest onto
the stack in reverse order (i.e. last parameter first) – since the stack grows down, the first of the
extra parameters (really the seventh parameter) parameter will be stored at the lowest address (this
inversion of parameters was historically used to allow functions to be passed a variable number of
parameters).
3. To call the subroutine, use the call instruction. This instruction places the return address on top of
the parameters on the stack, and branches to the subroutine code.
4. After the subroutine returns, (i.e. immediately following the call instruction) the caller must remove
any additional parameters (beyond the six stored in registers) from stack. This restores the stack to
its state before the call was performed.
5. The caller can expect to find the return value of the subroutine in the register RAX.
6. The caller restores the contents of caller-saved registers (r10, r11, and any in the parameter passing
registers) by popping them off of the stack. The caller can assume that no other registers were
modified by the subroutine.
Due to the way the calling convention is structured, it will typically be the case that some (or most)
of these steps will not make any changes to the stackd. For example, if there are six or fewer parameters,
then nothing is pushed onto the stack in that step. Likewise, programmers (and compilers) tyipcally keep
the results they care about out of the caller-saved registers in steps 1 and 6 to prevent excess pushes and
pops.

## The Callee’s Rules
>The definition of the subroutine should adhere to the following rules:
1. Allocate local variables by using registers or making space on the stack. Recall, the stack grows
down, so to make space on the top of the stack, the stack pointer should be decremented. The
amount by which the stack pointer is decremented depends on the number of local variables needed.
For example, if a local float and a local long (12 bytes total) were required, the stack pointer
would need to be decremented by 12 to make space for these local variables:
Listing 1.1: x86 callee code, part 2
sub rsp , 12
As with parameters, local variables will be located at known offsets from the stack pointer.
2. Next, the values of any registers that are designated callee-saved that will be used by the function
must be saved. To save registers, push them onto the stack. The callee-saved registers are RBX, RBP,
and R12 through R15 (RSP will also be preserved by the call convention, but need not be pushed on
the stack during this step).
After these three actions are performed, the actual operation of the subroutine may proceed. When
the subroutine is ready to return, the call convention rules continue
3. When the function is done, the return value for the function should be placed in RAX if it is not
already there.
4. The function must restore the old values of any callee-saved registers (RBX, RBP, and R12 through
R15) that were modified. The register contents are restored by popping them from the stack. Note,
the registers should be popped in the inverse order that they were pushed.
5. Next, we deallocate local variables. The easiest way to do this is to add to RSP the same amount
that was subtracted from it in step 1.
6. Finally, we return to the caller by executing a ret instruction. This instruction will find and remove
the appropriate return address from the stack.
