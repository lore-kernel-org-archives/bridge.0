Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jun 2008 15:53:50 +1000
Message-ID: <96CF49BD8B56384395D698BA99007FA32FA2B8@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>, bridge@osdl.org

I had a similar problem not long ago. Make sure that ip_conntrack is not
loaded. In my case, it was re-assembling all fragmented packets passing
through the bridge, and not fragmenting them again. The resulting large
packet was too big for the interface, and it got dropped.=20

Regards,
             Leigh
=20
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au
=20

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Fulvio
Ricciardi
Sent: Saturday, 28 June 2008 2:56 PM
To: bridge@osdl.org
Subject: [Bridge] 802.1q packets

Hi,

I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
tagged packets larger than 1470 bytes are not forwarded at
all by a bridge.
I think there is a bad interaction between bridge and
netfilter codes. Any chance to a have a patch to solve this
problem that limit the possibility to use the Linux bridges
in a environment with VLANs?

Best Regards
Fulvio Ricciardi

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
