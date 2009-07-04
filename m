MIME-Version: 1.0
In-Reply-To: <fed120860906092149t405d80a5y7fc32c5c05f1f450@mail.gmail.com>
References: <a8e2ebfb0906040128p25fa2960j1c78045caadfc9b6@mail.gmail.com>
	<fed120860906092149t405d80a5y7fc32c5c05f1f450@mail.gmail.com>
Date: Sat, 4 Jul 2009 19:30:07 +0530
Message-ID: <a8e2ebfb0907040700r26161db2q950d1c35d0c94d0@mail.gmail.com>
From: Ramasamy Chandramouli <ramasamycmouli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problem in mixing RSTP/STP configuration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>, bridge@lists.linux-foundation.org

Hi Srinivas,
Really sorry for this long gap in replying due to unavailability of
the test setup.

I'm using rstpd daemon in the switches RSTP_SW1 and RSTP_SW2. I've
also made the ports p0 and p1 to be non-P2P as well as non-edge ports.
The switch loop still exists and after quite a number of seconds, the
loop gets broken by transition of p0 link of RSTP_SW1 to blocking
state.

The problem seems to occur when the RSTP port p1 of RSTP_SW1 goes to
forwarding mode before p0 ports are put into blocking state. Could
there be a problem in computing port vector priorities when mixing STP
and RSTP, so that, while computing the port roles, the RSTP port p1 is
wrongly assigned the 'root' role from 'alternate' role, before moving
the port p0 to blocking?

I've checked with the IEEE-802.1D-2004 specification for the same.
I've also verified the timings for processing the BPDUs and assignment
of port states in the switch. They seem to be in conformance with the
specification.

Thanks in advance,
Ramasamy C

On Wed, Jun 10, 2009 at 10:19 AM, Srinivas M.A.<srinivas.aji@gmail.com> wro=
te:
> One thing that could be a problem is that p0 on the two RSTP switches
> are set to auto p2p. This means that the RSTP will assume that it is
> p2p if the link is duplex and that it is a broadcast LAN segment if
> the link is not duplex. This assumption is valid only if all switches
> on the network are STP capable and only hubs create non p2p LAN
> segments. That is not the case in your network since there is a non
> STP switch. Try administratively setting the p0 ports on the RSTP
> switches to have p2p set to no.
>
> On Thu, Jun 4, 2009 at 1:28 AM, Ramasamy
> Chandramouli<ramasamycmouli@gmail.com> wrote:
>> Hello,
>>
>> I'm using rstpd application over two switches and they are connected
>> to another Nortel switch which operates STP rather than RSTP. They are
>> all connected by a 10/100 ethernet switch which does not process
>> BPDUs. Here is a simplified diagram when the system is up and running.
>>
>> =A0+-------------+ =A0 =A0R
>> =A0| Root-Bridge o--------+
>> =A0+-------------+ =A0 =A0STP |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 +-----------o--------------+
>> =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0STP_SW_NORTEL =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 +-----------o--------------+
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 L | STP
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-----o-----+
>> =A0+------+ =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 | =A0 10/100 ethernet
>> =A0| Host o---------o =A0 =A0 =A0 =A0 =A0 | =A0 switch
>> =A0+------+ =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 | =A0 (no BPDU process=
ing)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +--o-----o--+
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0STP =A0 =A0 | =A0 =A0 | =A0 =A0STP
>> =A0 =A0 =A0 =A0 =A0 +----------+ =A0 =A0 +----------+
>> =A0 =A0 =A0 =A0p0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| p0
>> =A0 =A0 +-----o-----+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-----o-----+
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0 | p1 =A0 =A0 =A0 =A0 p1 | =A0 =A0 =A0 =A0 =
=A0 |
>> =A0 =A0 | RSTP_SW1 =A0o---------------o =A0RSTP_SW2 |
>> =A0 =A0 | =A0 =A0 =A0 =A0 =A0 | =A0 =A0 RSTP =A0 =A0 =A0| =A0 =A0 =A0 =
=A0 =A0 |
>> =A0 =A0 +-----------+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-----------+
>>
>> The MACs of the bridges and the root bridge to which they are all
>> synced with are:
>>
>> =A0 =A0Root bridge: =A0 =A0 00:11:22:xx:xx:xx
>> =A0 =A0STP_SW_NORTEL: =A0 00:11:58:xx:xx:xx
>> =A0 =A0RSTP_SW1: =A0 =A0 =A0 =A002:e0:xx:xx:44:01
>> =A0 =A0RSTP_SW2: =A0 =A0 =A0 =A002:e0:xx:xx:42:01
>>
>> The STP_SW_NORTEL carries the root bridge identifier in its STP BPDU
>> and the RSTP algorithm on RSTP_SW1 and RSTP_SW2 migrates the p0 port
>> to perform STP transactions. After a brief TopologyChange transaction,
>> the port states were as follows:
>>
>> =A0 Switch =A0 =A0Port =A0 =A0Root-Bridge =A0 =A0 =A0 =A0 Designated-Bri=
dge =A0 Role/State
>> =A0RSTP_SW1 =A0 =A0p0 =A0 =A0 00:11:22:xx:xx:xx =A0 02:e0:xx:xx:44:01 =
=A0 Root,Fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0p1 =A0 =A0 00:11:22:xx:xx:xx =A0 02:e0:xx:xx:=
44:01 =A0 Altn,Disc
>>
>> =A0RSTP_SW2 =A0 =A0p0 =A0 =A0 00:11:22:xx:xx:xx =A0 02:e0:xx:xx:42:01 =
=A0 Root,Fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0p1 =A0 =A0 00:11:22:xx:xx:xx =A0 02:e0:xx:xx:=
42:01 =A0 Desg,Fwd
>>
>> =A0p0 - auto-p2p, non-edge
>> =A0p1 - auto-p2p, auto-edge
>>
>> The cost and port/bridge priorities are not modified and are left to
>> defaults assigned by the rstpd application. Sniffing the BPDUs from
>> the host reveals that after a while only STP_SW_NORTEL switch is
>> sending out the hello packets, and the bridges RSTP_SW1 and RSTP_SW2
>> are in sync with it.
>>
>> I'm facing the following problem:
>>
>> If the link L is removed, the switch RSTP_SW1 and RSTP_SW2 ends up
>> forming a loop. The port RSTP_SW1::p1 comes to forwarding state before
>> blocking the port RSTP_SW1::p0. The following are the sequence of
>> ports states:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RSTP_SW1 =A0 =A0 =A0 =A0 =A0=
 RSTP_SW2
>> [before L is connected]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p0: =A0altn/disc =A0 =A0 =A0 =A0 =A0d=
esg/fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1: =A0root/fwd =A0 =A0 =A0 =A0 =A0 d=
esg/fwd
>>
>> [after L is connected]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p0: =A0root/fwd =A0 =A0 =A0 =A0 =A0 r=
oot/fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1: =A0altn/disc =A0 =A0 =A0 =A0 =A0d=
esg/fwd
>>
>> [after L is disconnected]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p0: =A0desg/fwd =A0 =A0 =A0 =A0 =A0 r=
oot/fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1: =A0root/disc =A0 =A0 =A0 =A0 =A0d=
esg/fwd
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p0: =A0desg/fwd =A0 =A0 =A0 =A0 =A0 r=
oot/fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1: =A0root/learn =A0 =A0 =A0 =A0 des=
g/fwd
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p0: =A0desg/fwd =A0 =A0 =A0 =A0 =A0 r=
oot/fwd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p1: =A0root/fwd =A0 =A0 =A0 =A0 =A0 d=
esg/fwd
>>
>> After disconnecting link L, the RSTP port moves through the
>> learning/forwarding states that puts the bridge to loop.
>>
>> If the mediating ethernet switch is removed and if the switches
>> RSTP_SW1 and RSTP_SW2 are directly connected to =A0STP_SW_NORTEL switch,
>> the switches RSTP_SW1 and RSTP_SW2 loops up, if the root bridge link,
>> R is removed. The sequence seems to be:
>>
>> =A0 =A0 =A0 1. =A0RSTP_SW2::p0 sends out a TC BPDU with its own bridge I=
D as
>> root bridge id.
>> =A0 =A0 =A0 2. =A0RSTP_SW1::p0 sends out a TC BPDU with the root bridge =
as
>> the lost root bridge's ID.
>> =A0 =A0 =A0 3. =A0The above when received by RSTP_SW2::p0, thinks that i=
t has
>> received a superior bridge and tries to sync up with the root bridge
>> ID sent by its neighbour: RSTP_SW1.
>>
>> After the above sequence, the port RSTP_SW1::p1 ends up in
>> learning/forwarding sequence which eventually forms a loop before
>> migrating any of the other STP ports to blocking/discarding mode.
>>
>> It would be of great help if some one could provide an insight into
>> what could be going wrong.
>>
>> Regards,
>> Ramasamy
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
