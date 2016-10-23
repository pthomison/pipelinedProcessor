onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/PROG/testcase
add wave -noupdate /dcache_tb/DUT/hitcounter
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/DUT/dcif/dhit
add wave -noupdate /dcache_tb/PROG/dcif/dmemload
add wave -noupdate /dcache_tb/PROG/expected_cache
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/iwait
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/dwait
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/iREN
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/dREN
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/dWEN
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/iload
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/dload
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/dstore
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/iaddr
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/daddr
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ccwait
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ccinv
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ccwrite
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/cctrans
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ccsnoopaddr
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramWEN
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramREN
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramstate
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramaddr
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramstore
add wave -noupdate -group MemoryC /dcache_tb/DUTMEM/ccif/ramload
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramREN
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramWEN
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramaddr
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramstore
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramload
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/ramstate
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/memREN
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/memWEN
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/memaddr
add wave -noupdate -group RAM /dcache_tb/DUTRAM/ramif/memstore
add wave -noupdate -group DCache /dcache_tb/DUT/cif/iwait
add wave -noupdate -group DCache /dcache_tb/DUT/cif/dwait
add wave -noupdate -group DCache /dcache_tb/DUT/cif/dREN
add wave -noupdate -group DCache /dcache_tb/DUT/cif/dWEN
add wave -noupdate -group DCache /dcache_tb/DUT/cif/iload
add wave -noupdate -group DCache /dcache_tb/DUT/cif/dload
add wave -noupdate -group DCache /dcache_tb/DUT/cif/dstore
add wave -noupdate -group DCache /dcache_tb/DUT/cif/daddr
add wave -noupdate -group DCache /dcache_tb/DUT/cif/ccwait
add wave -noupdate -group DCache /dcache_tb/DUT/cif/ccinv
add wave -noupdate -group DCache /dcache_tb/DUT/cif/ccwrite
add wave -noupdate -group DCache /dcache_tb/DUT/cif/cctrans
add wave -noupdate -group DCache /dcache_tb/DUT/cif/ccsnoopaddr
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/halt
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/ihit
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dhit
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemREN
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemWEN
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/flushed
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemload
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemstore
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemaddr
add wave -noupdate -group InternalDCache /dcache_tb/DUT/validTwo
add wave -noupdate -group InternalDCache /dcache_tb/DUT/validOne
add wave -noupdate -group InternalDCache /dcache_tb/DUT/updateWrite
add wave -noupdate -group InternalDCache /dcache_tb/DUT/updateRead
add wave -noupdate -group InternalDCache /dcache_tb/DUT/reqAddr
add wave -noupdate -group InternalDCache /dcache_tb/DUT/recUsed
add wave -noupdate -group InternalDCache /dcache_tb/DUT/prehitTwo
add wave -noupdate -group InternalDCache /dcache_tb/DUT/prehitOne
add wave -noupdate -group InternalDCache /dcache_tb/DUT/prehit
add wave -noupdate -group InternalDCache /dcache_tb/DUT/nextState
add wave -noupdate -group InternalDCache /dcache_tb/DUT/nRST
add wave -noupdate -group InternalDCache /dcache_tb/DUT/mstore
add wave -noupdate -group InternalDCache /dcache_tb/DUT/mload
add wave -noupdate -group InternalDCache /dcache_tb/DUT/loadAddrB
add wave -noupdate -group InternalDCache /dcache_tb/DUT/loadAddrA
add wave -noupdate -group InternalDCache /dcache_tb/DUT/dirtyData
add wave -noupdate -group InternalDCache /dcache_tb/DUT/dirtyAddr
add wave -noupdate -group InternalDCache /dcache_tb/DUT/destinationDirty
add wave -noupdate -group InternalDCache /dcache_tb/DUT/destination
add wave -noupdate -group InternalDCache /dcache_tb/DUT/currState
add wave -noupdate -group InternalDCache /dcache_tb/DUT/cdataTwo
add wave -noupdate -group InternalDCache /dcache_tb/DUT/cdataOne
add wave -noupdate -group InternalDCache /dcache_tb/DUT/cdata
add wave -noupdate -group InternalDCache /dcache_tb/DUT/dcif/dhit
add wave -noupdate -group InternalDCache /dcache_tb/DUT/cacheTwo
add wave -noupdate -group InternalDCache -expand -subitemconfig {{/dcache_tb/DUT/cacheOne[0]} -expand {/dcache_tb/DUT/cacheOne[0].data} -expand} /dcache_tb/DUT/cacheOne
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {280450 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1181250 ps}
