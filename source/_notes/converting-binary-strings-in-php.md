---
title: Converting binary strings to ASCII text in PHP
date: 2018-12-12
---

PHP has a couple of functions for converting between formats (such as
`hex2bin`).

The following function converts a binary string (i.e. a string made up of "0"
and "1" characters) into a regular PHP string:

```php
function bin_to_ascii($data) {
    $output = '';
    for ( $i = 0; $i < strlen( $data ); $i += 8 ) {
        $chunk = substr( $data, $i, 8 );
        $output .= pack('H*', base_convert($chunk, 2, 16));
    }
    return $output;
}

// Example:
$data  = '01001000011001010110110001101100011011110010110000100000';
$data .= '010101110110111101110010011011000110010000100001';

// Prints "Hello, World!"
echo bin_to_ascii($data);

```

The function slices the input string into chunks of 8 characters, because each
ASCII character is 8 bits long.

[pack](https://secure.php.net/manual/en/function.pack.php) is a nifty PHP
function for converting binary data into other forms.

In this example, the chunk of data is converted into actual binary data using
`base_convert`. `base_convert` is used to convert a base 2 (i.e. binary) number
into base 16 (hexadecimal). `pack` then converts the hex value into a readable
string. Each character is converted before being returned in one string.

**Important**:

The input string should be valid binary - it should only contain 1s and 0s, and
the length should be a multiple of 8. Weird things will happen otherwise.
