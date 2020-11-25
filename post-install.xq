xquery version "3.1";

import module namespace config = 'modules/config.xqm';

let $setup := (
    sm:chmod($config:app-root || '/modules/create.xql', 'rwsrwxr-x'),
    sm:chmod($config:app-root || '/modules/update.xql', 'rwsrwxr-x'),
    sm:chmod($config:app-root || '/modules/delete.xql', 'rwsrwxr-x')
)

return
    util:log('info', 'eXanore :: post-install : setuid done')
