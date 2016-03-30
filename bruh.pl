use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = '0.1';

%IRSSI = (
	name => 'bruh',
);

sub process_message {
	my ($server, $msg, $target, $nick) = @_;
	return unless $target =~ /^#(asanatest|nerds|direct-to-me)$/;
	$msg = lc $msg;
	my $destination = $target;
	$destination = $nick if $target eq "#direct-to-me";
	if ($msg =~ m/bru+h/) {
		$server->command("msg $destination Bruh");
	};
}
Irssi::signal_add_last('message public', sub {
	my ($server, $msg, $nick, $mask, $target) = @_;
	Irssi::signal_continue($server, $msg, $nick, $mask, $target);
	process_message($server, $msg, $target);
});
Irssi::signal_add_last('event privmsg', sub {
	my ($server, $msg, $nick, $address) = @_;
	Irssi::signal_continue($server, $msg, $nick, $address);
	process_message($server, $msg, '#direct-to-me', $nick);
});
