package Web::Encoding;
use strict;
use warnings;
our $VERSION = '1.0';
use Exporter::Lite;
use Encode;

our @EXPORT = qw(
  encode_web_utf8
  decode_web_utf8
  encode_web_charset
  decode_web_charset
  is_ascii_compat_charset_name
);

sub encode_web_utf8 ($) {
  return Encode::encode ('utf-8', $_[0]);
} # encode_web_utf8

sub decode_web_utf8 ($) {
  return Encode::decode ('utf-8', $_[0]); # XXX error-handling
} # decode_web_utf8

sub encode_web_charset ($$) {
  return Encode::encode ($_[0], $_[1]); # XXX
} # encode_web_charset

sub decode_web_charset ($$) {
  return Encode::decode ($_[0], $_[1]); # XXX
} # decode_web_charset

# XXX WA1 & Web Encodings
sub is_ascii_compat_charset_name ($) {
  my $name = $_[0] or return 0;
  if ($name =~ m{^
    utf-8|
    iso-8859-[0-9]+|
    us-ascii|
    shift_jis|
    euc-jp|
    windows-[0-9]+|
    iso-2022-[0-9a-zA-Z-]+|
    hz-gb-2312
  $}xi) {
    return 1;
  } else {
    return 0;
  }
} # is_ascii_compat_charset_name

=head1 LICENSE

Copyright 2011 Wakaba <w@suika.fam.cx>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
