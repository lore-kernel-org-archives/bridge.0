Message-ID: <4782706D.6000803@juniper.net>
Date: Mon, 07 Jan 2008 10:33:17 -0800
From: "David A. Ranch" <dranch@juniper.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridge with DHCP IP address
References: <478010E3.3020409@kotiportti.fi>
	<fed120860801071022k639af034s7e4abb1c19a323e0@mail.gmail.com>
In-Reply-To: <fed120860801071022k639af034s7e4abb1c19a323e0@mail.gmail.com>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Casper Gripenberg <casper.gripenberg@kotiportti.fi>
Cc: bridge@lists.linux-foundation.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
There are similar issues like this what using port forwarding with
standard iptables and there are specific iptables rules required to get
this working (I've documented those NAT specific issues in my IP
Masquerade HOWTO on the LDP).&nbsp; <br>
<br>
I'd recommend to take this specific issue to the ebtables forums as
this really isn't a bridging issue.<br>
<br>
--David<br>
<br>
<blockquote
 cite="mid:fed120860801071022k639af034s7e4abb1c19a323e0@mail.gmail.com"
 type="cite">
  <pre wrap="">Setting up eth0 as a bridge port and also having an IP address on it
is confusing. Better perhaps to run dhclient on the bridge interface
itself.

For filtering packets as you indicate, it should be possible to do
that using ebtables. I don't know details about it though.
With this filtering, you can probably filter the outgoing DHCP
requests from br0 to go out only on eth0 and not through eth1. (They
will be broadcast, so they will get sent out of both ports normally.)

On Jan 6, 2008 4:51 AM, Casper Gripenberg
<a class="moz-txt-link-rfc2396E" href="mailto:casper.gripenberg@kotiportti.fi">&lt;casper.gripenberg@kotiportti.fi&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi. I'm trying to run a bridge between my "internal"
network (eth1) and the external internet (eth0). I.e.
a very basic setup.

But I also want the bridge to have an IP address. I
read the docs here:
<a class="moz-txt-link-freetext" href="http://www.linux-foundation.org/en/Net:Bridge">http://www.linux-foundation.org/en/Net:Bridge</a>

Which say to set the forwarding delay to 0 and then run
dhclient on eth0:

# ifconfig eth0 0.0.0.0
# ifconfig eth1 0.0.0.0
# brctl setfd br0 0
# brctl addif br0 eth0
# dhclient eth0
# brctl addif br0 eth1
# ifconfig br0 up

The bridge works fine as a bridge, and eth0 gets
an IP address (although it takes a very long time
for the dhclient to aquire it).

But I can't reach the eth0 address from anywhere
except localhost. And I can't get out of the bridge
either to any other address..even though the routing
table it set up correctly I get destination unreachable
when I try to ping an external IP address from the
bridge box (logged in through the console).

What I want is for the bridge to have an IP address
and then I want to allow access to specific ports on
the bridge depending on if the packets are coming in
through eth0 or eth1. Is this possible to do?

Thanks.

Casper
    </pre>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Bridge mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a>
<a class="moz-txt-link-freetext" href="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</a>
  </pre>
</blockquote>
<br>
</body>
</html>

