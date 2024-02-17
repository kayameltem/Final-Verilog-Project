`timescale 1s / 100ms
`include "scp_079.v"
module fail_tb;
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
           {green,yellow,red} = 100 ;   //testing for 40s, while green equals 1   
           #40 {green,yellow,red} = 001 ;       // testing while red equals 1
        end
endmodule
