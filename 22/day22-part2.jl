type Fighter
    name::AbstractString
    points::Int
    damage::Int
    armor::Int
    mana::Int
end

immutable Spell
    mana::Int
    damage::Int
    points::Int
    turns::Int
    armor::Int
    recharge::Int
end

function fight!(fighter::Fighter, opponent::Fighter)
    damage = max(1, fighter.damage - opponent.armor)
    opponent.points -= max(1, fighter.damage - opponent.armor)
end

function apply_spells!(active_spells, fighter, opponent)
    total_armor = 0
    for (spell, turns_left) in active_spells
        if turns_left > 0
            opponent.points -= spell.damage
            total_armor += spell.armor
            fighter.mana += spell.recharge
            active_spells[spell] -= 1
        else
            pop!(active_spells, spell)
        end
    end
    fighter.armor = total_armor
end

const spells = [#     mana d  p  t  a  r
                Spell(53,  4, 0, 0, 0, 0)
                Spell(73,  2, 2, 0, 0, 0)
                Spell(113, 0, 0, 6, 7, 0)
                Spell(173, 3, 0, 6, 0, 0)
                Spell(229, 0, 0, 5, 0, 101)
                ]

min_mana = typemax(Int)

function find_min_mana(fighter, opponent, total_mana, active_spells)
    global min_mana

    if min_mana <= total_mana return total_mana end

    if fighter.points <= 0
        if fighter.name == "player" return typemax(Int) end
        min_mana = min(min_mana, total_mana)
        return total_mana
    end

    f1 = deepcopy(fighter)
    o1 = deepcopy(opponent)
    a1 = deepcopy(active_spells)

    if f1.name == "boss"
        apply_spells!(a1, o1, f1)
        if f1.points > 0
            fight!(f1, o1)
            return find_min_mana(o1, f1, total_mana, a1)
        end
        return total_mana
    end

    f1.points -= 1              # Difficulty 'hard'
    f1.points <= 0 && return typemax(Int)
    apply_spells!(a1, f1, o1)

    minimum(spells) do spell
        spell_mana = 0
        f = deepcopy(f1)
        a = deepcopy(a1)
        o = deepcopy(o1)

        if f.mana >= spell.mana
            damage = points = armor = recharge = 0
            for (s, turns_left) in a
                if turns_left > 0
                    damage += s.damage
                    points += s.points
                    armor += s.armor
                    recharge += s.recharge
                end
            end

            if spell.turns == 0 # Apply immediately
                spell_mana = spell.mana
                f.mana -= spell_mana

                o.points -= spell.damage
                f.armor += spell.armor
                f.points += spell.points
            elseif (damage == 0 || spell.damage == 0) &&
                (points == 0 || spell.points == 0) &&
                (armor == 0 || spell.armor == 0) &&
                (recharge == 0 || spell.recharge == 0)
                spell_mana = spell.mana
                f.mana -= spell_mana

                a[spell] = spell.turns
            end
        end
        if spell_mana == 0
            typemax(Int)
        else
            find_min_mana(o, f, total_mana + spell_mana, a)
        end
    end
end

boss = Fighter("boss", 71, 10, 0, 0)
player = Fighter("player", 50, 0, 0, 500)

println(find_min_mana(player, boss, 0, Dict{Spell, Int}()))
