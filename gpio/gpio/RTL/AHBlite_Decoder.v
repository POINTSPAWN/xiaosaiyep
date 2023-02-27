module AHBlite_Decoder
#(
    /*RAMCODE enable parameter*/
    parameter Port0_en = 1,
    /************************/

    /*RAMDATA enable parameter*/
    parameter Port1_en = 1,
    /************************/

    /*GPIO0 enable parameter*/
    parameter Port2_en = 1,
    /************************/

    /*SPI enable parameter*/
    parameter Port3_en=1,
    /************************/

    /*GPIO2 enable parameter*/
    parameter Port4_en=0
    /************************/

    
)(
    input [31:0] HADDR,

    /*RAMCODE OUTPUT SELECTION SIGNAL*/
    output wire P0_HSEL,

    /*RAMDATA OUTPUT SELECTION SIGNAL*/
    output wire P1_HSEL,

    /*GPIO0 OUTPUT SELECTION SIGNAL*/
    output wire P2_HSEL,

    /*UART OUTPUT SELECTION SIGNAL*/
    output wire P3_HSEL,       

    /*GPIO2 OUTPUT SELECTION SIGNAL*/
    output wire P4_HSEL  
);

//RAMCODE-----------------------------------

//0x00000000-0x0000ffff
/*Insert RAMCODE decoder code there*/
assign P0_HSEL = (HADDR[31:16] == 16'h0000) ? Port0_en : 1'd0;
/***********************************/



//PERIPHRAL-----------------------------

//0x40000028 OUT  ENABLE
//0X40000024 IN DATA
//0X40000020 OUT DATA
/*Insert WaterLight decoder code there*/
assign P2_HSEL = (HADDR[31:4] == 28'h4000002) ? Port2_en : 1'd0;
/***********************************/

//0x40000038 OUT  ENABLE
//0X40000034 IN DATA
//0X40000030 OUT DATA
/*Insert UART decoder code there*/
assign P3_HSEL = (HADDR[31:4] == 28'h4000003) ? Port3_en : 1'd0;
/***********************************/

//0x40000048 OUT  ENABLE
//0X40000044 IN DATA
//0X40000040 OUT DATA
/*Insert GPIO decoder code there*/
assign P4_HSEL = 1'd0;
/***********************************/

//RAMDATA-----------------------------
//0X20000000-0X2000FFFF
/*Insert RAMDATA decoder code there*/
assign P1_HSEL = (HADDR[31:16] == 16'h2000) ? Port1_en : 1'b0;
/***********************************/

endmodule