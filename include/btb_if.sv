`ifndef BTB_IF_VH
`define BTB_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface btb_if;

	word_t idex_pc_out;
	word_t idex_imm_ext;

	word_t ifid_pc_out;
	
	word_t target_pc_out;
	
	logic  match_found;

  modport bf (
    input  idex_pc_out, idex_imm_ext, ifid_pc_out, 
    output target_pc_out, match_found
  );
endinterface
`endif //BTB_IF_VH