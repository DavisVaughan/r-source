package R::Rd;

=head1 NAME
    
  R::Rd - parse files in Rd format
    
=head1 SYNOPSIS

  use R::Rd;

  ## quick parsing giving only name, title, aliases and keywords
  $rdinfo = R::Rd->info( "foo" );

  $rdinfo->{"name"};           # \name{} 
  $rdinfo->{"title"};          # \title{}
  @{$rdinfo->{"aliases"}};     # array with \alias{}es
  @{$rdinfo->{"keywords"}};    # array with \keyword{}s

=cut
          
use strict;
use Carp;
use FileHandle;
use R::Rdtools;

sub info {

    my ($class, $file) = @_;
    $class = ref($class) || $class;

    my $self = {};
    $_ = Rdpp($file);
    if(/\\name\{([^\}]*)\}/){
	$self->{"name"} = $1;
    }
    if(/\\title\{\s*([^\}]*)\s*\}/s){
	$self->{"title"} = $1;
	$self->{"title"} =~ s/\s+/ /sg;
    }
    if(/\\alias\{([^\}]*)\}/){
	push @{$self->{"aliases"}}, $1;
    }
    if(/\\keyword\{([^\}]*)\}/){
	push @{$self->{"keywords"}}, $1;
    }
    bless $self, $class;
}

1;
