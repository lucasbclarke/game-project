const std = @import("std");
const print = @import("std").debug.print;
const rl = @import("raylib");

const windowW: u16 = 1920;
const windowH: u16 = 1080;

const player = enum {
   var recPos = rl.Vector2.init(windowW / 2, windowH / 2);
   const recSize = rl.Vector2.init(100, 100);
   var recC: rl.Color = .red;
};

const border = enum {
   var recPos = rl.Vector2.init(0, 0);
   const recSize = rl.Vector2.init(windowW, windowH);
   const recC: rl.Color = .black;
};

fn movementofplayer() void {
   //if (rl.isKeyDown(.j) != true and rl.isKeyDown(.k) != true and rl.isKeyDown(.h) != true and rl.isKeyDown(.l) != true) {
   if (rl.isKeyDown(.j) != true and rl.isKeyDown(.k) != true) {
      player.recPos.y += 10;
   }


   if (player.recPos.y < 1 ) {
      player.recPos.y = 1;
   } else {
      if (rl.isKeyDown(.j)) {   
         player.recPos.y += 10;
      }
   }

   if (player.recPos.y > windowH - player.recSize.y - 180) {
      player.recPos.y = windowH - player.recSize.y - 180;
   } else if (rl.isKeyDown(.k)) {   
         player.recPos.y -= 10;
   } 

   if (player.recPos.x > (border.recSize.x - 590)) {
      player.recPos.x = player.recPos.x;
   } else {
      if (rl.isKeyDown(.l)) {
         player.recPos.x += 10;
      }                         
   }

   if (player.recPos.x < 1) {
      player.recPos.x = player.recPos.x;
   } else {
      if (rl.isKeyDown(.h)) {   
         player.recPos.x -= 10;
      }                         
   }

}


pub fn main() !void {
   rl.initWindow(windowW, windowH, "Window");
   defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.black);

        rl.drawRectangleV(border.recPos, border.recSize, border.recC);

        rl.drawFPS(500, 500);
        
        rl.drawRectangleV(player.recPos, player.recSize, player.recC);
      
        movementofplayer();    
    }
}
