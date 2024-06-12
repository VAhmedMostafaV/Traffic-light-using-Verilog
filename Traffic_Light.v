module traf(input reset,clk,sa,sb , output reg ra,ya,ga,rb,yb,gb);

reg[3:0] state_d,state_q;
localparam s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,
           s7=7,s8=8,s9=9,s10=10,s11=11,s12=12;

           
always@(*)
begin
  case(state_q)
    s0,s1,s2,s3,s4,s6,s7,s8,s9,s10 : state_d = state_q + 1;
    
    s5 : begin
           if(sb)
             state_d = s6;
           else
             state_d = s5;
         end
    
    s11 : begin
            if(~sa&&sb)
              state_d = s11;
            else 
              state_d = s12;
          end
    s12 : state_d = s0;
          default:state_d=s0;
  endcase
end  

always@(*)
begin 
ra = 0 ; ya = 0 ; ga = 0;
rb = 0 ; yb = 0 ; gb = 0;
  case(state_q)
    s0,s1,s2,s3,s4,s5: begin
                       ra = 0 ; ya = 0 ; ga = 1;
                       rb = 1 ; yb = 0 ; gb = 0;
                       end 
    s6:                begin
                       ra = 0 ; ya = 1 ; ga = 0;
                       rb = 1 ; yb = 0 ; gb = 0;
                       end 
    s7,s8,s9,s10,s11:  begin
                       ra = 1 ; ya = 0 ; ga = 0;
                       rb = 0 ; yb = 0 ; gb = 1;
                       end
    s12:               begin
                       ra = 1 ; ya = 0 ; ga = 0;
                       rb = 0 ; yb = 1 ; gb = 0;
                       end
  endcase                
end

always@(posedge clk , posedge reset)
begin
  if(reset)
    state_q<=s0;
  else
    state_q <= state_d;  
end

endmodule