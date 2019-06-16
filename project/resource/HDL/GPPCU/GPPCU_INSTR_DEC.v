// Run as combination circuit
module GPPCU_INSTR_DEC (
    iOPC,
    oCW
);
    // params
    `include "GPPCU_PARAMETERS.vh"
    
    // ports
    input   [4:0]           iOPC;
    output  [CW_BITS-1:1]   oCW;

    // port details
    reg     [CW_BITS-1:1]   oCW;
    
    // logic
    always @(iOPC) begin /*
                           U U     L L                                      
                           S S     M M F    A    B  G                       
                           E E     E E P    L    S  M R                       
                           R R F A M M O    O    E  E E                         
                           E E P L | | P    P    L  M G                        
                           G G O O R W C    C       R W                        
                           A B P P D R 3..0 3..0 1. D R  */ case (iOPC)
        NOP   : oCW <= 'b__0_0_0_0_0_0_0000_0000_00_0_0;
        MOV   : oCW <= 'b__1_1_0_1_0_0_xxxx_0001_00_0_1;
        MVN   : oCW <= 'b__1_1_0_1_0_0_xxxx_0010_00_0_1;
        ADC   : oCW <= 'b__1_1_0_1_0_0_xxxx_0011_00_0_1;
        SBC   : oCW <= 'b__1_1_0_1_0_0_xxxx_0100_00_0_1;
        AND   : oCW <= 'b__1_1_0_1_0_0_xxxx_0101_00_0_1;
        ORR   : oCW <= 'b__1_1_0_1_0_0_xxxx_0110_00_0_1;
        XOR   : oCW <= 'b__1_1_0_1_0_0_xxxx_0111_00_0_1;
        ADI   : oCW <= 'b__1_0_0_1_0_0_xxxx_1000_01_0_1;
        SBI   : oCW <= 'b__1_0_0_1_0_0_xxxx_1001_01_0_1;
        MVI   : oCW <= 'b__0_0_0_1_0_0_xxxx_1010_xx_0_1;
        LSL   : oCW <= 'b__1_0_0_1_0_0_xxxx_1011_xx_0_1;
        LSR   : oCW <= 'b__1_0_0_1_0_0_xxxx_1100_xx_0_1;
        ASR   : oCW <= 'b__1_0_0_1_0_0_xxxx_1101_xx_0_1;
        ITOF  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FTOI  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FMUL  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FDIV  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FADD  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FSUB  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FNEG  : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        FSQRT : oCW <= 'b__0_0_1_0_0_0_0000_xxxx_00_0_0;
        LDL   : oCW <= 'b__1_1_0_0_1_0_xxxx_xxxx_00_0_1;
        LDCI  : oCW <= 'b__0_0_0_0_0_0_xxxx_xxxx_11_1_1;
        STL   : oCW <= 'b__1_1_0_0_0_1_xxxx_xxxx_00_0_0;
        default: oCW <= 0;
        endcase 
    end
endmodule