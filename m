Message-ID: <2e59e6970812032018lcedac31o4de5cd71de718bd0@mail.gmail.com>
Date: Thu, 4 Dec 2008 04:18:54 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <25142.1228351616@death.nxdomain.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1228350057.4344.141.camel@fuego>
	<25142.1228351616@death.nxdomain.ibm.com>
Subject: Re: [Bridge] [Bonding-devel] received packet with own address as
	source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: bridge@lists.linux-foundation.org, bonding-devel@lists.sourceforge.net

On Thu, Dec 4, 2008 at 12:46 AM, Jay Vosburgh <fubar@us.ibm.com> wrote:
> Matthew Kent <matt@bravenet.com> wrote:
>
>>Trying to determine if I have a misconfiguration, misunderstanding or
>>have stumbled on a bug.

I think there is a bug here although the description doesn't sound
like the buggy case.

Here is the specific configuration that produces the same message and
I think should not:

A bond in fail-over mode, either both or just one PHY connected.

VLANs configured on the bond device.

Two of the bond VLAN interfaces members of the same bridge, stp
enabled.  An external bridge device (actually a fancy transparent
traffic shaper with a history of occasional seizure) connecting the
same two VLANs.  A router on the higher-numbered (so less preferred by
STP) VLAN.  So the nominal case is for STP to block forwarding, but if
the traffic shaper fails then the bridge will start sending traffic
direct to the router.

Now when the traffic shaper is forwarding traffic, the BPDUs sent out
the preferred port come back on the non-preferred port and force it
into blocking mode as desired.  But the "received packet with own
address as source address" message is logged.
