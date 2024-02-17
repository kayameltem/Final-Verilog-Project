`timescale 1s / 100ms
`include "scp_079.v"
module a1trouble_tb;
        reg green,yellow,red, clock;  //inputs
        wire a_security, a_database, a_control_sys, cheat_out;  //outputs
        wire integer timer ;  //output timer, shows current time
        wire [2:0] state;  //output state, shows current state
        scp_079 UUT(a_security, a_database, a_control_sys, cheat_out, state, timer,green,yellow,red, clock);  //unit under test
        
        initial begin
            clock = 1'b0; //clock initializer
            #0.5;
            forever begin
                #0.5 clock = ~clock;  //clock generator
                end
            #30 $finish;
           
        end 
       initial begin
           {green,yellow,red} = 100 ;   //testing for 25s, while green equals 1 
           #25 {green,yellow,red} = 010;   //testing for 22s, while yellow equals 1 
           #22 {green,yellow,red} = 100;   //testing while green equals 1                  
        end   
endmodule
