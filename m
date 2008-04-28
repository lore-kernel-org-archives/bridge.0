Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Apr 2008 17:28:16 +1000
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA1E8@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: Re: [Bridge] Preventing packet reassembly
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

=20
> Are you using hardware that does Large Receive Offload (LRO)? Most

As far as I can tell, no. I'm using standard e1000 cards, which I
believe don't do LRO. Ethtool -S eth1 doesn't show any counters related
to LRO.

> hardware doesn't. The other possible problem would be
ebtables/iptables
> rules. =20

Hmm. This may be the problem.

I have iptables rules on the management interface of the box, but not on
any of the ports which participate in bridging.
By removing iptables from my bootup, I get a properly functioning
bridge.

Why would iptables rules on one interface affect traffic bridged on
other interfaces? I'm presuming it's some kind of interaction with the
ip_conntrack module? Any way to stop it from loading?


Cheers,
Leigh.



-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@vyatta.com]=20
Sent: Monday, 28 April 2008 3:36 PM
To: Leigh Sharpe
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Preventing packet reassembly
> =20
> =20
> Are you using hardware that does Large Receive Offload (LRO)? Most
> hardware doesn't. The other possible problem would be
ebtables/iptables
> rules.  The bridge itself doesn't reassemble packets, but firewall
> rules might.
