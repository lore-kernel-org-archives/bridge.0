Message-ID: <cab05a880610110233u2d48c96ena9915cf2bb3cb682@mail.gmail.com>
Date: Wed, 11 Oct 2006 11:33:55 +0200
From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
In-Reply-To: <452CB1E0.9020008@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cab05a880610090952g2e94b7aka84ccb0ef8fd8013@mail.gmail.com>
	<452CB1E0.9020008@cambridgebroadband.com>
Subject: Re: [Bridge] Link fail over - bridge slow learning !?!
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: bridge@lists.osdl.org, shemminger@osdl.org

Alex,

That was my first thought too, but STP is disabled.

On 10/11/06, Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
> Alexander Indenbaum wrote:
> > Hello,
> >
> > I'm playing with dual-port NIC driver level link failover:
> > * Driver exposes single network interface to the OS and operates both
> > ports in active-passive failover mode.
> > * Upon Link down event on active port, driver switches active and
> > passive ports transparently for the OS.
> >
> > I'm testing the driver using Linux bridge module: "failover" dual-port
> > NIC connected with two cables back-to-back to eth0 and eth1 which are
> > part of br0 bridge.
> >
> > I simulate link fail with following scenario:
> > * At t0 both eth0 and eth1 port links are UP, traffic is accepted by
> > eth0 and forwarded to br0
> > * At t1 I manually unplug eth0 cable, causing link to go down.
> > "Failover" driver switches the traffic immediately from eth0 to eth1,
> > while using the same MAC address.
> > * From t1 till t1+12 secs packets are accepted by eth1 but dropped by
> > bridge and not forwarded to br0.
> > * At t1+12 secs bridge starts forwarding packets from eth1 to br0
> >
> > Hmm... I would expect that eth0 link down event would flush from
> > bridge's table any MAC address associated with the port and that the
> > bridge would start forwarding packets from eth1 to br0 immediately.
> >
> > Why does it take ~12 secs for bridge to learn that MAC address moved
> > from eth0 to eth1 in the described scenario?
> >
>
> It may be spanning tree, rather than MAC address learning that takes
> so long.  Bridges spend a while just listening before forwarding, to
> avoid becoming part of a bridging loop.
>
> Experiment with:
>
>    brctl showstp br0
>    brctl stp br0 off
>    brctl setfd br0 1
>
> Alex
>
>


-- 
Alexander Indenbaum
