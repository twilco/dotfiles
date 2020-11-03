define hook-stop
refresh
end

define dbps
delete breakpoints
end

define sbps
save breakpoints breakpoints.txt
end

target remote localhost:8080
refresh

# Try to reload breakpoints from the current directory (if we saved any last debug session).
set breakpoint pending on
source breakpoints.txt

set history filename ~/.gdb_history
set history save on
set history size 10000

# Pretty print structs and arrays.
set print pretty on
set print array on
# When displaying a pointer to an object, identify the actual (derived) type of the object rather than the declared
# type, using the virtual function table. Note that the virtual function table is required—this feature can only work
# for objects that have run-time type identification; a single virtual method in the object’s declared type is
# sufficient.
set print object on

# Remove duplicate history entries up to 5 entries back from the most recent.
# https://sourceware.org/gdb/onlinedocs/gdb/Command-History.html#Command-History
set history remove-duplicates 5

# These make gdb never pause in its output.
# https://web.mit.edu/gnu/doc/html/gdb_16.html
set height 0
set width 0
