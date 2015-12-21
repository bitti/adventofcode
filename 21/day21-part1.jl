const format = r"Hit Points: (\d+)
Damage: (\d+)
Armor: (\d+)"m
const boss_attributes = map(parse, match(format, readall(STDIN)).captures)

immutable Item
    cost::Int
    damage::Int
    armor::Int
end

type Fighter
    points::Int
    damage::Int
    armor::Int
end

const weapons = [
    Item(8,  4, 0)
    Item(10, 5, 0)
    Item(25, 6, 0)
    Item(40, 7, 0)
    Item(74, 8, 0)]

const armors = [
    Item(0, 0, 0)               # Dummy armor to make it optional
    Item(13, 0, 1)
    Item(31, 0, 2)
    Item(53, 0, 3)
    Item(75, 0, 4)
    Item(102, 0, 5)]

const rings = [
    Item(0, 0, 0)               # Dummy rings to make them optional
    Item(0, 0, 0)
    Item(25, 1, 0)
    Item(50, 2, 0)
    Item(100, 3, 0)
    Item(20, 0, 1)
    Item(40, 0, 2)
    Item(80, 0, 3)]

function add_item!(f::Fighter, i::Item)
    f.damage += i.damage
    f.armor += i.armor
end

function fight!(fighter::Fighter, opponent::Fighter)
    damage = max(1, fighter.damage - opponent.armor)
    opponent.points -= max(1, fighter.damage - opponent.armor)
end

function cost(items::Item...)
    sum(i -> i.cost, items)
end

costs = 2^31

for w in weapons, a in armors, (r1, r2) in combinations(rings, 2)
    player = Fighter(100, 0, 0)
    boss = Fighter(boss_attributes...)

    for item in [w a r1 r2]
        add_item!(player, item)
    end

    fighter, opponent = player, boss
    while fighter.points > 0
        fight!(fighter, opponent)
        fighter, opponent = opponent, fighter
    end

    if opponent == player
        costs = min(costs, cost(w, a, r1, r2))
    end
end

println(costs)
