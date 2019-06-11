module GPPCU_STALL_GEN #
(
    parameter
    NUMREG = 32
)
(
    iACLK,
    inRST,
    iREGD,
    iREGA,
    iREGB,
    iVALID,
    oENABLED,
    
    iWRREG,
    iWRREG_VALID
);
    // ports
    input                   iACLK;
    input                   inRST;
    input                   iREGD;
    input   [NUMREG-1:0]    iREGA;
    input   [NUMREG-1:0]    iREGB;
    input                   iVALID;
    output                  oENABLED;
    
    input   [NUMREG-1:0]    iWRREG;
    input                   iWRREG_VALID;
    
    // regs
    reg     [NUMREG-1:0]    occupied;
    wire    [NUMREG-1:0]    rq_mask_a, rq_mask_b; 
    
    // logics
    assign oENABLED = !(|(occupied & (rq_mask_a | rq_mask_b)));
    generate 
        genvar i;
        for(i = 0; i < NUMREG; i = i + 1) begin : SELECT
            wire outsig = ~iWRREG_VALID | (i == iWRREG);
            wire insig  = oENABLED && iVALID && i == iREGD; 
            always @(posedge iACLK) begin
                if(~inRST)
                    occupied[i] = 0;
                else
                    occupied[i] = (occupied[i] & outsig) | insig; 
            end
            
            assign rq_mask_a[i] = i == iREGA;
            assign rq_mask_b[i] = i == iREGB;
        end
    endgenerate
endmodule