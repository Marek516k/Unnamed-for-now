local Config = {}

Config.window_width = 1080
Config.window_height = 720

Config.gravity = 600
Config.side_collision_threshold = 10

Config.player = {
    spawn_x = 600,
    spawn_y = 400,
    speed = 150,
    jump_force = 500,
    jump_acceleration = 150,
    max_health = 100,
}

Config.enemy = {
    spawn_x = 200,
    spawn_y = 400,
    speed = 120,
    jump_force = 500,
    jump_acceleration = 150,
    max_health = 100,
    jump_cooldown = 2,
}

Config.weapon = {
    width = 32,
    height = 32,
    damage = 25,
    offset_x = 16,
}

Config.ui = {
    player_health_x = 20,
    player_health_y = 20,
    enemy_health_x = Config.window_width - 220,
    enemy_health_offset_y = -30,
    health_bar_height = 20,
    health_bar_max_width = 200,
}

Config.weapon_animation = {
    frame_duration = 0.2,
    frame_count = 3,
    frame_width = 32,
    frame_height = 32,
}

Config.combat = {
    hit_cooldown = 1,
    enemy_attack_range = {
        cube = 50,
        slime = 100,
    },
    damage_by_type = {
        cube = 10,
        slime = 200,
    },
}

return Config