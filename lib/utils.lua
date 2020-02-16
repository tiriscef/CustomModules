local random = math.random

--<< Just some helper functions >>
Tirislib_Utils = {}

function Tirislib_Utils.weighted_average(a, weight_a, b, weight_b)
    return (a * weight_a + b * weight_b) / (weight_a + weight_b)
end

function Tirislib_Utils.sgn(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

function Tirislib_Utils.weighted_random(weights)
    local sum = 0
    for i = 1, #weights do
        sum = sum + weights[i]
    end

    local random_index = random(sum)
    local index = 0

    repeat
        index = index + 1
        random_index = random_index - weights[index]
    until random_index < 1

    return index
end

--<< Just some table helper functions >>
Tirislib_Tables = {}

function Tirislib_Tables.count(tbl)
    local count = 0

    for _ in pairs(tbl) do
        count = count + 1
    end

    return count
end

--- Removes all values of the given table that equal the given value.
--- This function doesn't preserve the original order.
function Tirislib_Tables.remove_all(tbl, value)
    for i = #tbl, 1, -1 do
        if tbl[i] == value then
            if i ~= #tbl then
                tbl[i] = tbl[#tbl]
            end
            tbl[#tbl] = nil
        end
    end
end

function Tirislib_Tables.get_keyset(tbl)
    local ret = {}
    local index = 1

    for key, _ in pairs(tbl) do
        ret[index] = key
        index = index + 1
    end

    return ret
end

function Tirislib_Tables.to_lookup(array)
    local ret = {}

    for i = 1, #array do
        ret[array[i]] = true
    end

    return ret
end

--https://gist.github.com/Uradamus/10323382
function Tirislib_Tables.shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end

    return tbl
end

-- clones the table, tables inside will be referenced
function Tirislib_Tables.copy(tbl)
    local ret = {}

    for key, value in pairs(tbl) do
        ret[key] = value
    end

    return ret
end

-- clones the table and all tables inside
-- assumes that there are no circular structures
function Tirislib_Tables.recursive_copy(tbl)
    local ret = {}

    for key, value in pairs(tbl) do
        if type(value) == "table" then
            ret[key] = Tirislib_Tables.recursive_copy(value)
        else
            ret[key] = value
        end
    end

    return ret
end

function Tirislib_Tables.contains(tbl, element)
    for _, value in pairs(tbl) do
        if element == value then
            return true
        end
    end

    return false
end

function Tirislib_Tables.contains_key(tbl, key)
    return tbl[key] ~= nil
end

function Tirislib_Tables.merge(lh, rh)
    for _, value in pairs(rh) do
        lh[#lh + 1] = value
    end

    return lh
end

function Tirislib_Tables.set_fields(tbl, fields)
    if fields ~= nil then
        for key, value in pairs(fields) do
            tbl[key] = value
        end
    end

    return tbl
end

function Tirislib_Tables.merge_arrays(lh, rh)
    for i = 1, #rh do
        lh[#lh + 1] = rh[i]
    end

    return lh
end

function Tirislib_Tables.sum(tbl)
    local ret = 0.

    for _, value in pairs(tbl) do
        ret = ret + value
    end

    return ret
end

function Tirislib_Tables.array_sum(tbl)
    local ret = 0.

    for i = 1, #tbl do
        ret = ret + tbl[i]
    end

    return ret
end

function Tirislib_Tables.product(tbl)
    local ret = 1.

    for _, value in pairs(tbl) do
        ret = ret * value
    end

    return ret
end

function Tirislib_Tables.array_product(tbl)
    local ret = 1.

    for i = 1, #tbl do
        ret = ret * tbl[i]
    end

    return ret
end

function Tirislib_Tables.empty(tbl)
    for k in pairs(tbl) do
        tbl[k] = nil
    end
end

function Tirislib_Tables.new_array(size, value)
    local ret = {}

    for i = 1, size do
        ret[i] = value
    end

    return ret
end

function Tirislib_Tables.new_array_of_arrays(count)
    local ret = {}

    for i = 1, count do
        ret[i] = {}
    end

    return ret
end

function Tirislib_Tables.insertion_sort_by_key(array, key)
    local length = #array

    for j = 2, length do
        local current = array[j]
        local current_value = array[j][key]
        local i = j - 1

        while i > 0 and array[i][key] < current_value do
            array[i + 1] = array[i]
            i = i - 1
        end
        array[i + 1] = current
    end

    return array
end
