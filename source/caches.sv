/*
  Patrick Thomison & Emily Fredette

  this block holds the i and d cache
*/

// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module caches (
  input logic CLK, nRST,
  datapath_cache_if dcif,
  caches_if cif
);
  // import types
  import cpu_types_pkg::word_t;

  parameter CPUID = 0;

  word_t instr;
  word_t daddr;

  // icache
  icache  ICACHE(CLK, nRST, dcif, cif);
  // dcache
  dcache  DCACHE(CLK, nRST, dcif, cif);

endmodule