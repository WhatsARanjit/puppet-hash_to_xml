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

# Defaults, 2 spaces indent
file { '/tmp/example.xml':
  ensure  => file,
  content => hash_to_xml($data),
}

# 1 tab indent, starting with 1 indent
file { '/tmp/example2.xml':
  ensure  => file,
  content => hash_to_xml($data, 1, "\t", 1),
}
