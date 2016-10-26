onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /dcache_tb/PROG/testcase
add wave -noupdate /dcache_tb/DUT/hitcounter
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/DUT/dcif/dhit
add wave -noupdate /dcache_tb/PROG/dcif/dmemload
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/halt
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/ihit
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dhit
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemREN
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemWEN
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/flushed
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemload
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemstore
add wave -noupdate -group dcif /dcache_tb/DUT/dcif/dmemaddr
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/hitCache
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/currState
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/updateRecentUsed
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/validTwo
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/validOne
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/updateWrite
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/updateRead
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/reqAddr
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/recUsed
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/prehitTwo
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/prehitOne
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/prehit
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/nRST
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/mstore
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/mload
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/loadAddrB
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/loadAddrA
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/dirtyData
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/dirtyAddr
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/destinationDirty
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/cdataTwo
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/cdataOne
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/cdata
add wave -noupdate -expand -group InternalDCache /dcache_tb/DUT/dcif/dhit
add wave -noupdate -expand -group InternalDCache -subitemconfig {{/dcache_tb/DUT/cacheTwo[1]} -expand {/dcache_tb/DUT/cacheTwo[1].data} -expand} /dcache_tb/DUT/cacheTwo
add wave -noupdate -expand -group InternalDCache -expand -subitemconfig {{/dcache_tb/DUT/cacheOne[1]} -expand {/dcache_tb/DUT/cacheOne[1].data} -expand} /dcache_tb/DUT/cacheOne
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {373026 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {645750 ps}
