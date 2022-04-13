local genHotfix = require(PluginPath..'/GenHotfix')

function onPublish(handler)
    if handler.genCode then 
        handler.genCode = false
        genHotfix(handler)
    end
end