#!/usr/bin/perl -w
use strict;

print '<!doctype html><html><head><meta charset="utf-8"/><link rel="stylesheet" href="style.css"/><title>Doc</title></head><body>';

# Buffers
my $text='';
my $js='';
my $js_text='';

my %char2entity=(
  '<' => '&lt;', '>' => '&gt;', '&' => '&amp;', '"' => '&quot', "'" => '&apos;'
);

sub encode_html_entities($) {
  my ($text) = @_;
  $text =~ s/([><&\"\'])/$char2entity{$1}/ge;
  return $text;
}

sub flush_text() {
  return if( $text eq '' );

  # TODO: Convert Markdown into HTML
  print "<p class='text'>", encode_html_entities($text), "</p>";

  $text='';
}

sub flush_js() {
  return if( $js eq '' );

  print "<pre class='code'>", encode_html_entities($js_text), "</pre>";
  print "<script>$js</script>";

  $js = '';
  $js_text = '';
}

# Read file line by line
while(<>) {

  if( m{^///} ) {
    # Ignore comment: /// ->
  }

  elsif( m{^//!(.*)$} ) {
    # Direct HTML: //! <div> -> <div>

    flush_js();
    flush_text();

    print "$1\n";
  }

  elsif ( m{^//(.*)$} ) {
    # Text: // foo -> <b>foo</b>

    flush_js();

    $text .= "$1\n";
  }

  elsif ( m{^\s*$} ) {
    # Empty line: ->

    flush_text();

    if($js_text ne '') {
      $js_text .= "\n";
    }

    if($js ne '') {
      $js .= "\n";
    }
  }

  elsif ( m{^print\((.*)\);$} ) {
    # Print variable value

    flush_js();
    flush_text();

    print "<p class='print'>$1=<script>document.writeln($1);</script></p>\n";
  }

  elsif ( m{^(.*)//-$} ) {
    # Hidden JS: var foo; //-

    flush_text();

    $js .= "$1\n";
  }

  elsif( m{^(.+)$} ) {
    # JavaScript

    flush_text();

    $js_text .= "$1\n";
    $js .= "$1\n";
  }

  else {
    print STDERR "Unknown statement: \"$_\".\n";
  }
}

flush_text();
flush_js();

print "</body></html>";
