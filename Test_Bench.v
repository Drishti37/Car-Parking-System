`timescale 1ns / 1ps

module tb_parking_system;

    reg clk=0;
    reg reset_n;
    reg sensor_entrance;
    reg sensor_exit;
    reg [1:0] password;

    wire GREEN_LED;
    wire RED_LED;

    parking_system uut (
        .clk(clk),
        .reset_n(reset_n),
        .sensor_entrance(sensor_entrance),
        .sensor_exit(sensor_exit),
        .password(password),
        .GREEN_LED(GREEN_LED),
        .RED_LED(RED_LED)
    );
    
initial 
      begin
      clk = 0;
      forever #5 clk = ~clk;
      end


initial 
       begin
       reset_n = 0;
       sensor_entrance = 0;
       sensor_exit = 0;
       password = 2'b00;


       #10 reset_n = 1;

       #20 sensor_entrance = 1; 
           password = 2'b10;    
       #20 sensor_entrance = 0;
       #20 password = 2'b11;
       #20 password = 2'b00;
        
       #20 sensor_entrance = 1;
           sensor_exit=1;
       #20 sensor_entrance = 0;
           sensor_exit=0;
       #20 password = 2'b11;
       #20 password = 2'b00;
         
       #20 sensor_exit = 1;
       #20 sensor_exit = 0;
        
       #20 sensor_entrance = 1;
       #20 sensor_entrance = 0;
       #20 password = 2'b11;
       #20 password = 2'b00;
        
       #20 sensor_entrance = 1;
       #20 sensor_entrance = 0;
       #20 password = 2'b11;
       #20 password = 2'b00;
        
       #20 sensor_exit = 1;
       #20 sensor_exit = 0;
        
       #20 sensor_exit = 1;
       #20 sensor_exit = 0;
      
       #20 sensor_entrance = 1;
       #20 sensor_entrance = 0;
       #20 password = 2'b11;
       #20 password = 2'b00;

       #20 sensor_exit = 1;
       #20 sensor_exit = 0;
        
        
       #1000;
       $finish;
       
    end
endmodule
