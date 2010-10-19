Date: Mon, 18 Oct 2010 20:33:58 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101018203358.25775937@nehalam>
In-Reply-To: <AANLkTikRJVdCG=HD45cgjkFzK6H3i+WPyKMHz28+mXSb@mail.gmail.com>
References: <AANLkTikRJVdCG=HD45cgjkFzK6H3i+WPyKMHz28+mXSb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Giving enslaved interface an IP?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Taranowski <tom@baringforge.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 18 Oct 2010 19:16:18 -0700
Thomas Taranowski <tom@baringforge.com> wrote:

> I have bridged eth0 and eth1, where eth0 is the world, and eth1 has
> some locally administered targets with normal IPs.  On eth1, I also
> have some other devices with 192.168.x.x addresses I locally assigned.
>  I'd like to give my eth1 a 192.168.x.x address, and treat the
> 192.168.x.x network as something like a local network, where anything
> else get's bridged across to eth0.  I'm running into some problems.
> 
> First, when I try to ping anything on the 192.168.x.x network, it
> get's sent out the wrong interface ( eth0 ), rather than eth1.  I
> expected the bridge to broadcast the arp request to both interfaces.
> 
> Second, giving eth1 an ip address, in addition to being bridged, had
> no obvious effect.  Can I even do this?
> 
> Any suggestions on where to look for additional information on this,
> or things to try?

Don't put IP address on only one interface unless you are
setting up a brouter[1]. If you want to do firewalling then
add ebtables rules to block traffic; doing firewalling
with addressing won't work because the address won't be accessible 
as you found out.


1. A brouter requires additional ebtables to make packets flow.
