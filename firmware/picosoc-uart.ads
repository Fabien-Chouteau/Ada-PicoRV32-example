package PicoSOC.UART is

   procedure Set_Baud_Rate (Baud : Positive);

   procedure New_Line;
   procedure Put (C : Character);
   procedure Put (S : String);
   procedure Put_Line (C : Character);
   procedure Put_Line (S : String);

end PicoSOC.UART;
