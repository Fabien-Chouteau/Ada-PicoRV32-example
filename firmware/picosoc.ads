with Interfaces; use Interfaces;
with System;

package PicoSOC is

   function Read_Cycle return Unsigned_32;

   procedure Busy_Loop (Cycles : Unsigned_32);

   type GPIO_Register is array (0 .. 31) of Boolean
     with Pack, Size => 32;

   ---------------
   -- Registers --
   ---------------

   SPICTRL : Unsigned_32
     with Volatile, Address => System'To_address (16#02000000#);

   UART_CLKDIV : Unsigned_32
     with Volatile, Address => System'To_address (16#02000004#);

   UART_Data : Unsigned_32
     with Volatile, Address => System'To_address (16#02000008#);

   GPIO : GPIO_Register
     with Volatile_Full_Access, Address => System'To_address (16#03000000#);

   GPIO_Data: Unsigned_32
     with Volatile, Address => System'To_address (16#03000000#);

end PicoSOC;
