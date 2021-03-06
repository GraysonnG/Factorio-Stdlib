--luacheck: ignore
project = 'Factorio Stdlib'
description = 'Factorio Standard Library'
full_description = [[
The Factorio Standard Library aims to extend the Factorio Lua api with well-tested, documented, and easy-to-use functions to make modding easier.
]]

--will pay for
format = 'markdown'
readme = '../build/doc/readme.md'

convert_opt = true
merge = false

alias('p','tparam')
alias('r','treturn')

examples = {'../build/doc/examples'}

--Shortcut for referring to concept targets in tparam and treturn
local Concepts = {
    ['Position'] = true,
    ['BoundingBox'] = true,
    ['Color'] = true,
    ['Vector'] = true,
    ['SimpleItemStack'] = true
}
local api_url = 'http://lua-api.factorio.com/latest/%s.html%s'
custom_see_handler('^Lua([%w_]+)(%.?[%w_]*)$',
    function(name, section)
        local url
        if Concepts[name] then
            local header = 'Concepts'
            section = '#'..name
            url = api_url:format(header, section)
        else
            local header = 'Lua'..name
            name = #section > 0 and name..section or name
            section = (#section > 0 and ('#'..header..section)) or ''
            url = api_url:format(header, section)
        end
        return name, url
    end
)
-- Factorio name:  Concepts.Position expands to Concept Position
-- useful for @see refrences
custom_see_handler('^Concepts%.?([%w_%.]*)$',
    function(section)
        local header, name, url
        header = 'Concepts'
        name = header ..' '..section
        url = api_url:format(header, '#'..section)
        return name, url
    end
)
custom_see_handler('^defines(%.?[%w_%.]*)$',
    function(section)
        local name, url
        name = 'defines'..section
        url = api_url:format('defines', '#'..name)
        return name, url
    end
)

local wikipat = 'https://en.wikipedia.org/wiki/%s'
custom_see_handler('^wiki (.+)',
    function(name)
        local url = wikipat:format(name)
        return name, url
    end
)

--https://forums.factorio.com/viewtopic.php?t=32039#p202158
custom_see_handler('^(http[s]?%:%/%/.-) (.+)$',
    function(url, name)
        return name, url
    end
)

-- -- define a @callback tag:
-- custom_tags = { { 'callback', hidden = true } }
-- -- show a label beside functions tagged with @callback.
-- custom_display_name_handler = function(item, default_handler)
--   if item.tags.callback then
--     return item.name .. ' [callback]'
--   end
--   return default_handler(item)
-- end
