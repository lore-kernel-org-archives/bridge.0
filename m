Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08AC8610D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B25DE610D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCs13PMPX8ktYmxkw39mM9YPDRfPhpM9eptQi2YcYp8=;
 b=L5t9OgKwtKjq3mSvHjj5Dp+RqWBQW3yTAMYFkXfR5O1nRxOeWIkzdwrNdLVDaEzb/efaC25tunHgm7ttS6FXYzOhklJCSw9Ze9ZdklPs0LIlj91SbRd8yNKe5Mp1MudAWHQ0PTU1OUprYkZhRTXrAQUkny8RDpwZcx5mAtub+ZjxP5rGVTQawAsUsfcNrnKEvzD2izQ2XJkwYraedxmfMCx1/Jssb4wYKz5A0zrKioiwBacR+OQFxvbG2yJqsTnSdKGQKx3B+S8COIihDOUp7iDdCYOKTU8tC9qRyytes3KkJCVntv9VAByaylQjTp371CqfgPRRkvcFNz0jsQvQxg==
Date: Thu, 21 Jul 2022 16:27:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YtlUWGdgViyjF6MK@shredder>
References: <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <YtQosZV0exwyH6qo@shredder>
 <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
 <20220721115935.5ctsbtoojtoxxubi@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721115935.5ctsbtoojtoxxubi@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@kapio-technology.com, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Jul 21, 2022 at 02:59:35PM +0300, Vladimir Oltean wrote:
> On Sun, Jul 17, 2022 at 05:53:22PM +0200, netdev@kapio-technology.com wrote:
> > > 3. What happens to packets with a DA matching the zero-DPV entry, are
> > > they also discarded in hardware? If so, here we differ from the bridge
> > > driver implementation where such packets will be forwarded according to
> > > the locked entry and egress the locked port
> > 
> > I understand that egress will follow what is setup with regard to UC, MC and
> > BC, though I haven't tested that. But no replies will get through of course
> > as long as the port hasn't been opened for the iface behind the locked port.
> 
> Here, should we be rather fixing the software bridge, if the current
> behavior is to forward packets towards locked FDB entries?

I think the bridge needs to be fixed, but not to discard packets. If I
decided to lock a port, it means I do not blindly trust whoever who
is behind the port, but instead want to authorize them first. Since an
unauthorized user is able to create locked FDB entries we need to
carefully define what they mean. I tried looking information about MAB
online, but couldn't find detailed material that answers my questions,
so my answers are based on what I believe is logical, which might be
wrong.

Currently, the bridge will forward packets to a locked entry which
effectively means that an unauthorized host can cause the bridge to
direct packets to it and sniff them. Yes, the host can't send any
packets through the port (while locked) and can't overtake an existing
(unlocked) FDB entry, but it still seems like an odd decision. IMO, the
situation in mv88e6xxx is even worse because there an unauthorized host
can cause packets to a certain DMAC to be blackholed via its zero-DPV
entry.

Another (minor?) issue is that locked entries cannot roam between locked
ports. Lets say that my user space MAB policy is to authorize MAC X if
it appears behind one of the locked ports swp1-swp4. An unauthorized
host behind locked port swp5 can generate packets with SMAC X,
preventing the true owner of this MAC behind swp1 from ever being
authorized.

It seems like the main purpose of these locked entries is to signal to
user space the presence of a certain MAC behind a locked port, but they
should not be able to affect packet forwarding in the bridge, unlike
regular entries.

Regarding a separate knob for MAB, I tend to agree we need it. Otherwise
we cannot control which locked ports are able to populate the FDB with
locked entries. I don't particularly like the fact that we overload an
existing flag ("learning") for that. Any reason not to add an explicit
flag ("mab")? At least with the current implementation, locked entries
cannot roam between locked ports and cannot be refreshed, which differs
from regular learning.
