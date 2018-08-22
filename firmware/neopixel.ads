with System;
with Interfaces; use Interfaces;

generic
   Number_Of_Pixels     : Unsigned_32;
   Peripheral_Base_Addr : System.Address;
package Neopixel is

   type Pixel is record
      B, R, G : Unsigned_8;
   end record
     with Size => 32, Volatile_Full_Access;

   for Pixel use record
      B at 0 range 0 .. 7;
      R at 0 range 8 .. 15;
      G at 0 range 16 .. 23;
   end record;

   subtype Pixel_Id is Unsigned_32 Range 1 .. Number_Of_Pixels;

   Pixels : array (Pixel_Id) of Pixel := (others => (0, 0, 0));
   --  Pixel buffer, you can directly read from and write to it

   procedure Set_All (Pix : Pixel);
   --  Set all the pixel in the buffer with the same value

   procedure Send;
   --  Send the pixels buffer to the hardware

   function To_Pixel (H, S, V : Unsigned_8) return Pixel;
   --  Convert HSV value to a neopixel

   function Img (Pix : Pixel) return String;
   --  Return a string representation of the pixel components (R, G, B)

end Neopixel;
