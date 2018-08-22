with System.Machine_Code; use System.Machine_Code;

package body PicoSOC is

   ----------------
   -- Read_Cycle --
   ----------------

   function Read_Cycle return Unsigned_32 is
      Ret : Unsigned_32;
   begin
      Asm ("rdcycle %0",
           Outputs  => Unsigned_32'Asm_Output ("=r", Ret),
           Volatile => True);
      return Ret;
   end Read_Cycle;

   ---------------
   -- Busy_Loop --
   ---------------

   procedure Busy_Loop (Cycles: Unsigned_32) is
      Start : constant Unsigned_32 := Read_Cycle;
   begin
      while Read_Cycle - Start < Cycles loop
         null;
      end loop;
   end Busy_Loop;
end PicoSOC;
