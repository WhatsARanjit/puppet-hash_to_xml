# hash_to_xml

#### Table of Contents

1. [Overview](#overview)
1. [Functions](#functions)
    * [node_groups()](#node_groups)
    * [get_nodes()](#get_nodes)

## Overview

Convert a Puppet hash into XML data.

## Functions

### hash_to_xml()

Convert a Puppet hash into XML data.

`hash_to_xml()` given the following data:

```puppet
$data = {
  '?xml version="1.0" encoding="UTF-8"?' => false,
  'xml' => {
    'fruit' => 'apple',
    'vegetables' => {
      'green' => 'cucumber',
      'brown' => 'potato'
    },
    'nested' => {
      'one' => {
        'foo' => 'bar',
      },
      'two' => {
        'foo' => 'bar',
      }
    }
  }
}

file { '/tmp/example.xml':
  ensure  => file,
  content => hash_to_xml($data),
}
```

The file at `/tmp/example.xml` will contain:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xml>
  <fruit>apple</fruit>
  <vegetables>
    <green>cucumber</green>
    <brown>potato</brown>
  </vegetables>
  <nested>
    <one>
      <foo>bar</foo>
    </one>
    <two>
      <foo>bar</foo>
    </two>
  </nested>
</xml>
```

#### Arguments:

* `data`

  Puppet hash of intended XML data.  Keys set to strings will be XML values like this:

  `'key' => 'value'` converts to `<key>value</key>``

  Keys set to hashes create opening and closing tags like this:

  `parent => { ... }` converts to `<parent>...</parent>`

  Keys set to `false` will open but not close like this:

  `?xml version="1.0" encoding="UTF-8"?' => false` converts to `<?xml version="1.0" encoding="UTF-8"?>`

  _Required_

* `indent`

  Starting indent in case you want to nest generated XML into other XML.

  Default: `0`

* `indent character`

  Chracter used for indent.  Can be used to choose between tabs, spaces, etc.
  
  Default: `\s`  

* `indent character count`

  The number of indent characters to use.  Can be used to decide 4 spaces, 2 tabs, etc.

  Default: `2`

_Type:_ rvalue

## Maintainers

This repositority is largely the work of some Puppet community members.
It is not officially maintained by Puppet, or any individual in
particular. Issues should be opened in Github. Questions should be directed
at the individuals responsible for committing that particular code.
