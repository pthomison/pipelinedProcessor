/*
Patrick Thomison
Emily Fredette
forward unit
*/
`include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"

module forward_unit (
  forward_unit_if fuif
);

  import cpu_types_pkg::*;


always_comb begin 
  fuif.ForwardA = 2'b00; //standard operation
  fuif.ForwardB = 2'b00; //standard operation


  //pg 331 pdf
  if ( fuif.exm_WEN && (fuif.exm_wsel_out != 0) ) begin
    if  ( fuif.exm_wsel_out == fuif.idex_rs_out ) begin //|| ((fuif.idex_rs_out == fuif.exm_rt_out) && fuif.exm_itype_out ) ) begin
      //porta is from exm_outport - which is from the prior alu restult
      fuif.ForwardA = 2'b10; 
    end
    if (  fuif.exm_wsel_out == fuif.idex_rt_out ) begin // || ((fuif.idex_rt_out == fuif.exm_rt_out) && fuif.exm_itype_out ) ) begin
      //portb is from exm_outport - which is from the prior alu restult
      fuif.ForwardB = 2'b10;
    end
  end

//pg 334 pdf
//need to debug IF statements 
  if ( fuif.mwb_WEN && (fuif.mwb_wsel_out != 0) ) begin
    if ( ! ((fuif.exm_WEN && fuif.exm_wsel_out) && (fuif.exm_wsel_out == fuif.idex_rs_out) ) ) begin
      if  (fuif.mwb_wsel_out == fuif.idex_rs_out ) begin //|| ((fuif.idex_rs_out == fuif.mwb_rt_out) && fuif.mwb_itype_out ) ) begin
        //porta is wdat after WDAT MUX in WB stage (wdat_temp)
        fuif.ForwardA = 2'b01;
      end
    end


    if ( ! ((fuif.exm_WEN && fuif.exm_wsel_out) && (fuif.exm_wsel_out == fuif.idex_rt_out)) ) begin
      if  ( fuif.mwb_wsel_out == fuif.idex_rt_out ) begin //|| ((fuif.idex_rt_out == fuif.mwb_rt_out) && fuif.mwb_itype_out ) )begin
        //portb is wdat after WDAT MUX in WB stage
        fuif.ForwardB = 2'b01;
      end
    end

  end



end //comb

endmodule