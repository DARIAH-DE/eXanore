xquery version "3.1";

import module namespace config='http://www.edirom.de/tools/eXanore/config' at 'modules/config.xqm';
import module namespace exanoreParam='http://www.eXanore.com/param' at 'modules/params.xqm';

declare function local:mkcol-recursive($collection, $components) {
    if (exists($components)) then
        let $newColl := concat($collection, "/", $components[1])
        return (
            xmldb:create-collection($collection, $components[1]),
            local:mkcol-recursive($newColl, subsequence($components, 2))
        )
    else
        ()
};

(: Helper function to recursively create a collection hierarchy. :)
declare function local:mkcol($collection, $path) {
    local:mkcol-recursive($collection, tokenize($path, "/"))
};


let $prepareDataCollection := 
    if( xmldb:collection-available($exanoreParam:dataCollectionURI) )
    then
        let $log := util:log('info', 'eXanore :: post-install : data collection already prepared')
        return true()
    else
        let $log := util:log('info', 'eXanore :: post-install : createing data collection')
        return
            local:mkcol("", $exanoreParam:dataCollectionURI)

let $setup := (
    sm:chmod(xs:anyURI( $config:app-root || '/modules/create.xql' ), 'rwsrwxr-x'),
    sm:chmod(xs:anyURI( $config:app-root || '/modules/update.xql' ), 'rwsrwxr-x'),
    sm:chmod(xs:anyURI( $config:app-root || '/modules/delete.xql' ), 'rwsrwxr-x'),
    util:log('info', 'eXanore :: post-install : setuid done')
    )

return
    util:log('info', 'eXanore :: post-install : done')
