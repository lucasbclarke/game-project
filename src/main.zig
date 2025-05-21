const std = @import("std");
const print = @import("std").debug.print;
const rl = @import("raylib");

const windowW: u16 = 1440;
const windowH: u16 = 900;

const player = enum {
    var recPos = rl.Vector2.init(650, 900);
    const recSize = rl.Vector2.init(100, 100);
    var recC: rl.Color = .red;
};

const border = enum {
    var recPos = rl.Vector2.init(0, 0);
    const recSize = rl.Vector2.init(windowW, windowH);
    const recC: rl.Color = .blue;
};

const objective = enum {
    var recPos = rl.Vector2.init(0, 450);
    const recSize = rl.Vector2.init(50, 200);
    const recC: rl.Color = .pink;
};

fn movementofplayer() void {
    if (rl.isKeyDown(.j) != true and rl.isKeyDown(.k) != true) {
        player.recPos.y += 10;
    }

    if (player.recPos.y < 1) {
        player.recPos.y = 1;
    } else {
        if (rl.isKeyDown(.j)) {
            player.recPos.y += 10;
        }
    }

    if (player.recPos.y > windowH - player.recSize.y) {
        player.recPos.y = windowH - player.recSize.y;
    } else if (rl.isKeyDown(.k)) {
        player.recPos.y -= 10;
    }

    if (player.recPos.x > (border.recSize.x - 100)) {
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

fn touchingObject() bool {
    if (player.recPos.x <= 50) {
        if (player.recPos.y <= 650 and player.recPos.y >= 350) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

pub fn main() !void {
    var reachedObj: bool = undefined;

    var camera = rl.Camera2D{
        .target = .init(border.recPos.x, border.recPos.y),
        .offset = .init(0, 0),
        .rotation = 0,
        .zoom = 1,
    };

    rl.initWindow(windowW, windowH, "Window");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        if (touchingObject() == true) {
            reachedObj = true;
        }

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.green);

        camera.begin();
        defer camera.end();

        rl.drawRectangleV(border.recPos, border.recSize, border.recC);

        rl.drawRectangleV(player.recPos, player.recSize, player.recC);

        rl.drawRectangleV(objective.recPos, objective.recSize, objective.recC);

        //trying to implement reset logic
        if (reachedObj and rl.isKeyDown(.r)) {
            player.recPos.x = 650;
            player.recPos.y = 800;
            camera.target.x = border.recPos.x;
            camera.target.y = border.recPos.y;
            movementofplayer();
            reachedObj = false;
        } else if (reachedObj) {
            rl.drawText("You have reached the objective", windowW / 4, windowH / 2, 20, .black);
        } else {
            movementofplayer();
        }
        
        rl.drawFPS(@intFromFloat(camera.target.x + 10), @intFromFloat(camera.target.y + 10));

        if (rl.isKeyDown(.right)) {
            camera.target.x += 5;
        }

        if (rl.isKeyDown(.left)) {
            camera.target.x -= 5;
        }

        if (rl.isKeyDown(.up)) {
            camera.target.y -= 5;
        }

        if (rl.isKeyDown(.down)) {
            camera.target.y += 5;
        }

        if (rl.isKeyDown(.r)) {
            camera.target = .init(0, 0);
        }
    }
}
