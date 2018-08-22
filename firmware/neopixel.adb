package body Neopixel is

   Data_Register : Pixel
     with Address => Peripheral_Base_Addr;

   -------------
   -- Set_All --
   -------------

   procedure Set_All (Pix : Pixel) is
   begin
      Pixels := (others => Pix);
   end Set_All;

   ----------
   -- Send --
   ----------

   procedure Send is
   begin
      for Pix of Pixels loop
         Data_Register := Pix;
      end loop;
   end Send;

   --------------
   -- To_Pixel --
   --------------

   function To_Pixel (H, S, V : Unsigned_8) return Pixel is
      R, G, B : Unsigned_8;

      Region, Remainder : Unsigned_32;
      P, Q, T : Unsigned_8;
   begin
      if S = 0 then
         R := V;
         G := V;
         B := V;
      else

         Region := Unsigned_32 (H / 43);
         Remainder := (Unsigned_32 (H) - (Region * 43)) * 6;

         P := Unsigned_8 (Shift_Right (Unsigned_32 (V) * (255 - Unsigned_32 (S)), 8));
         Q := Unsigned_8 (Shift_Right (Unsigned_32 (V) * (255 - Shift_Right (Unsigned_32 (S) * Remainder, 8)), 8));
         T := Unsigned_8 (Shift_Right (Unsigned_32 (V) * (255 - Shift_Right (Unsigned_32 (S) * (255 - Remainder), 8)), 8));

         case (Region) is
            when      0 => R := V; G := T; B := P;
            when      1 => R := Q; G := V; B := P;
            when      2 => R := P; G := V; B := T;
            when      3 => R := P; G := Q; B := V;
            when      4 => R := T; G := P; B := V;
            when others => R := V; G := P; B := Q;
         end case;
      end if;
      return (B, R, G);
   end To_Pixel;

   ---------
   -- Img --
   ---------

   function Img (Pix : Pixel) return String
   is ("(R:" & Pix.R'Img & " G:" & Pix.G'Img & " B:" & Pix.B'Img & ")");

end Neopixel;
