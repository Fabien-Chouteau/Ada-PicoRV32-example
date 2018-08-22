with Ada.Text_Io; use Ada.Text_Io;
with System;
with Interfaces;  use Interfaces;
with PicoSOC;     use PicoSOC;
with Neopixel;

procedure Firmware is

   Seed : Unsigned_32 := 123456789;

   ----------
   -- Rand --
   ----------

   function Rand return Unsigned_32 is
   begin
      Seed := (22695477 * Seed + 1);
      return Seed;
   end Rand;

   package Neo is new Neopixel (8 * 8, System'To_address (16#05000000#));
   use Neo;

   type Animation is (Off,
                      Candle,
                      Slow_Rainbow, Rainbow, Fast_Rainbow,
                      White,
                      Red, Orange, Yellow, Green, Cyan, Blue, Violet, Pink);

   subtype Fixed_Colors is Animation range Red .. Pink;

   Hues : array (Fixed_Colors) of Unsigned_8
     := (Red    => 0,
         Orange => 21,
         Yellow => 42,
         Green  => 80,
         Cyan   => 128,
         Blue   => 169,
         Violet => 203,
         Pink   => 212
        );

   Anim : Animation := Candle;
   Frame : Unsigned_32 := 0;

   V : Unsigned_8 := 50;

   Candle_V : Unsigned_8;
begin

   loop

      --  Check inputs every 30 frames
      if Frame mod 30 = 0 then

         --  User LED blink
         GPIO (0) := not GPIO (0);

         --  Check animation button
         if GPIO (1) then
            if Anim /= Animation'Last then
               Anim := Animation'Succ (Anim);
            else
               Anim := Animation'First;
            end if;

            Put_Line ("Switching animation:" & Anim'Img);
         end if;

         --  Check value button
         if GPIO (2) then
            V := V + 20;
            Put_Line ("New V:" & V'Img);
         end if;
      end if;

      --  Do animation
      case Anim is

         when Off =>

            Set_All ((0, 0, 0));

         when Candle =>

            case Rand mod 3 is
               when      0 => Candle_V := Candle_V - 1;
               when      1 => Candle_V := Candle_V + 1;
               when others => null;
            end case;
            case Rand mod 10 is
               when      0 => Candle_V := Candle_V - 3;
               when      1 => Candle_V := Candle_V + 3;
               when others => null;
            end case;

            case Rand mod 20 is
               when      0 => Candle_V := Candle_V - 6;
               when      1 => Candle_V := Candle_V + 6;
               when others => null;
            end case;

            Set_All (To_Pixel (H => 18 + (Candle_V mod 7),
                               S => 255,
                               V => (V mod 200) + (Candle_V mod 50)));

         when Slow_Rainbow .. Fast_Rainbow =>

            declare
               Offset : constant Unsigned_32 :=
                 Frame / (case Anim is
                            when Slow_Rainbow => 100,
                            when Rainbow      => 10,
                            when others       => 2);

            begin
               for Index in Pixel_Id loop
                  Pixels (Index) := To_Pixel
                    (H => Unsigned_8 ((Index + Offset) mod 256),
                     S => 255,
                     V => V);
               end loop;
            end;

         when White =>

            Set_All (To_Pixel (H => 0, S => 0, V => V));

         when Fixed_Colors =>

            Set_All (To_Pixel (H => Hues (Anim), S => 255, V => V));

         end case;

      --  Send pixel data
      Neo.Send;

      --  Wait a little bit
      Busy_Loop (100_000);

      --  Next frame id
      Frame := Frame + 1;

   end loop;

end Firmware;
