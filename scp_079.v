`timescale 1s / 100ms

module scp_079(
    output reg a1,    // Attack security output
    output reg a2,    // Attack Database output
    output reg a3,    // Attack Control System output
    output reg cheat_out,  // Cheat output
    output reg [2:0]current_state,  // Current state output
    output integer timer,    //timer output
    input green,yellow,red,clock
   );
   
    reg [2:0]next_state;
    localparam [2:0] s0 = 3'b000;   // Lay Low State   (initial state)
    localparam [2:0] s1 = 3'b001;   // Cheat State
    localparam [2:0] s2 = 3'b010;   // Attack Security State
    localparam [2:0] s3 = 3'b011;   // Attack Database State
    localparam [2:0] s4 = 3'b100;   // Fail State   (finish state)
    localparam [2:0] s5 = 3'b101;   // Connect State   (finish state)

    initial begin
         timer = 1; 
         current_state = s0;    //initialization of current_state
         next_state = s0;       //initialization of next_state
         {a1,a2,a3,cheat_out} = 4'b0000;     //initialization of output bits
         end
    always #1 timer <= timer +1;   // timer generator
    always @(posedge clock)begin
        case(current_state)
            s0:    // if current_state is  Lay Low state 
                if(green && timer >=20 ) begin  //if green = 1 and timer is higher than or eqaul to 20
                    next_state = s2;   // set next_state to s2
                    a1 = 1;    //set output a1 = 1
                    end
                else if(yellow)  //if input yellow is high
                    next_state = s0;   // set next_state to s0
                else if(red) begin  // if input red is high
                    next_state = s1;    // set next_state to s1
                    cheat_out = 1;    //set output check_out = 1
                    end
           s1:    // if current state is cheat state
                if (timer >= 15)begin  //if  timer is higher than or equals to 15s      
                    if(red)
                        next_state = s4;     // set next_state to s4
                    else begin  
                        next_state = s0;     // set next_state to s0
                       {a1,a2,a3,cheat_out} = 4'b0000;   //set outputs    
                       end  
                end
           s2:  // if current_state is Attack Security State
                if(green & timer >= 10)begin  //if input green is high and timer is higher than or equal to 10
                    next_state = s3;     // set next_state to s3
                    a2 = 1;   //set output a2 = 1
                    end
                else if(yellow)begin  //if input yellow is high
                    next_state = s0;     // set next_state to s0
                    a1 = 0;   //set output a1 = 0
                    end
                else if(red)begin  //if input red is high
                    next_state = s1;    // set next_state to s1
                    cheat_out = 1;   //set output check_out = 1
                    end
           s3:   // if the current state is Attack Database State
                if(green & timer >= 10)begin  //if green is high and timer is higher than or equal to 10
                    next_state = s5;     // set next_state to s5
                    a3 = 1;    //set output a3 = 1
                    end
                else if(yellow)begin  //if input yellow is high
                    next_state = s2;     // set next_state to s2
                    a2 = 0;    //set output a2 = 1
                    end
                else if(red)begin  //if input red is high
                    next_state = s1;     // set next_state to s1
                    cheat_out = 1;    //set output check_out = 1
                    end          
        endcase
        if(next_state != current_state)  //if current_state changes, set timer = 1
            timer <= 1; 
        current_state <= next_state;      // set current_state into next_state             
    end
    
    
endmodule
