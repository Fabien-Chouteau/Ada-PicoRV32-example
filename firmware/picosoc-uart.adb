package body PicoSOC.UART is

   -------------------
   -- Set_Baud_Rate --
   -------------------

   procedure Set_Baud_Rate (Baud : Positive) is
   begin
      UART_CLKDIV := 16_000_000 / Unsigned_32 (Baud);
   end Set_Baud_Rate;

   --------------
   -- New_Line --
   --------------

   procedure New_Line is
   begin
      Put (ASCII.CR);
      Put (ASCII.LF);
   end New_Line;

   ---------
   -- Put --
   ---------

   procedure Put (C : Character) is
   begin
      UART_Data := Unsigned_32 (Character'Pos (C));
   end Put;

   ---------
   -- Put --
   ---------

   procedure Put (S : String) is
   begin
      for C of S loop
         Put (C);
      end loop;
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (C : Character) is
   begin
      Put (C);
      New_Line;
   end Put_Line;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (S : String) is
   begin
      Put (S);
      New_Line;
   end Put_Line;

end PicoSOC.UART;
