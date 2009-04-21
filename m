MIME-Version: 1.0
In-Reply-To: <26bd38970904170318u1258868etbd6ff9225ec7c677@mail.gmail.com>
References: <26bd38970904170318u1258868etbd6ff9225ec7c677@mail.gmail.com>
Date: Tue, 21 Apr 2009 21:37:50 +0000
Message-ID: <fed120860904211437l7f3369ebq815b0f036eb35e32@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Help on configuring ports for RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jon Vincent <jon.bvincent@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi,
Sorry for the delayed reply.

It sounds like RSTP is setting the port states to the expected values,
though I can't be sure without knowing the bridge IDs of ES1, ES2 and
the external switch.

What you are using doesn't seem to be a regular Linux bridge, right?
Have you modified the rstpd to receive/send BPDUs and set port states
correctly for this platform?
In particular, you need to check whether STP_OUT_port_set_state() is
doing the right thing for that bridge, i.e. when a port is set to
disabled, it should not forward packets out through that port, and it
should not process received packets on that port: In particular it
should update its forwarding table based on packets received on that
port.

You could see if that is the issue by repeatedly inspecting the MAC
tables on the bridges during your test.

Srinivas

On Fri, Apr 17, 2009 at 10:18 AM, Jon Vincent <jon.bvincent@gmail.com> wrot=
e:
> Hello,
> I'm testing the userspace RSTPD daemon using the source from:
>
> https://lists.linux-foundation.org/pipermail/bridge/2009-February/006178.=
html
>
> The switch setup under testing is pictured below:
>
>
> =A0Uplink =A0 =A0 =A0 =A0 =A0 =A0 =A0 Uplink
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> =A0 =A0|u1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|u2
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 T =A0 =A0 =A0 =A0|
> [Eth.Switch]---------[Eth.Switch]
> =A0 ES1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ES2
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> =A0 =A0|c1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|c2
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> =A0 CPU1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPU2
>
> The ethernet switch is from Marvell and supports distributed switching
> architecture (DSA). The control interface to the switch is from the
> CPU and the rstpd is run on the CPU. The CPU's ethernet port is also
> connected to the ethernet switch but it does not participate for STP
> and is not bridged.
>
> Each CPU has two pseudo network interfaces (u1 and T) that are bridged
> and RSTP is run on the bridge. When both uplinks u1 and u2 are
> connected to an external switch, rstpd detects the loop and puts one
> of the uplink to discarding mode. Here are the port states and
> configurations that i'm using for the above setup:
>
> Switch =A0 =A0 =A0 =A0Port =A0 =A0 =A0AutoEdge =A0 P2P =A0 AdminEdge
> ES1 =A0 =A0 =A0 =A0 =A0 u1 =A0 =A0 =A0 =A0Yes =A0 =A0 =A0 =A0Yes =A0 No
> =A0 =A0 =A0 =A0 =A0 =A0 =A0T =A0 =A0 =A0 =A0 No =A0 =A0 =A0 =A0 Yes =A0 N=
o
> ES2 =A0 =A0 =A0 =A0 =A0 u2 =A0 =A0 =A0 =A0Yes =A0 =A0 =A0 =A0Yes =A0 No
> =A0 =A0 =A0 =A0 =A0 =A0 =A0T =A0 =A0 =A0 =A0 No =A0 =A0 =A0 =A0 Yes =A0 N=
o
>
> rstpd's computed port states:
> =A0 =A0 =A0 =A0 =A0 =A0 Switch =A0 =A0 =A0 =A0Port =A0 =A0 =A0State
> Root bridge =A0ES1 =A0 =A0 =A0 =A0 =A0 u1 =A0 =A0 =A0 =A0forwarding
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 T =A0 =A0 =A0 =A0 for=
warding
> =A0 =A0 =A0 =A0 =A0 =A0 ES2 =A0 =A0 =A0 =A0 =A0 u2 =A0 =A0 =A0 =A0discard=
ing
> Root port =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0T =A0 =A0 =A0 =A0 forwarding
>
> I'm trying to ping CPU2 from CPU1 which works. Given the above state
> table, the packets are sent through the link T from CPU1 to CPU2 and i
> do not have packet drops. When trying to ping CPU1 from CPU2, there
> are around 50% packet drops. In this case too, the packets can only be
> sent through T since the link u2 is in discarding mode.
>
> I suspected it could be a configuration issue in the ethernet switch
> and to test that, i stopped the rstpd and the ping works fine in both
> the directions. If the network interface u2 is down'ed (by plugging
> out the cable), the ping happens smoothly without packet drops. The
> only scenario where the packet drop seems to happen is when the
> non-root bridge has one of its port in discarding mode.
>
> It would be really helpful if someone could let me know if i'm wrong
> in any of the configuration to be done for RSTP.
>
> Thanks,
> Jon
>
