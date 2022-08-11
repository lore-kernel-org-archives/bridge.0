Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DA4960F57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 526D460F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGEs0gi6zE0+s8j80eORUFW0EiYDSHx6gLYg0JILxdE=;
 b=fbQkqdAE4DRXh4IWa9e/DrQb/DqVkWHXIx3qTjpbmMDuL6uLcbxePWwRhLbahGyfkay4Z6+pZ+bFzBjIGqhJpUdKN7Fq/JygeHUVp6DqIhE2biyz6Az6dZnlBl+RsZTavdbUaPAz9qNudcqVdIGKd/j8m8ymCV9Pj4t6m1OVCJdYchgYmBBQd8VD9L82HnrMrROloAtpe+E+/N27JPWprKDh++cDjqiD5c4PT3jVCt7+dTnv92J0FM67VUcB7EpDbO1VDo6lVIxNJhUNdgz7Y+7mO5gzn8xY4OP1UqAa0nQsjOpGRmC5TftC26mmBGUAktcQJGvfbUYcSPcM/pcLjw==
Date: Thu, 11 Aug 2022 14:28:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YvTn847P/Ga3Ulb0@shredder>
References: <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <79683d9cf122e22b66b5da3bbbb0ee1f@kapio-technology.com>
 <YvIm+OvXvxbH6POv@shredder>
 <6c6fe135ce7b5b118289dc370135b0d3@kapio-technology.com>
 <YvNcitNnyFxTw8bs@shredder>
 <2491232d5c017d94ca3213197a3fb283@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2491232d5c017d94ca3213197a3fb283@kapio-technology.com>
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
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, Aug 10, 2022 at 10:40:45AM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-10 09:21, Ido Schimmel wrote:
> > On Tue, Aug 09, 2022 at 10:00:49PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-08-09 11:20, Ido Schimmel wrote:
> > > > On Mon, Aug 01, 2022 at 05:33:49PM +0200, netdev@kapio-technology.com
> > > > wrote:
> > > > > On 2022-07-13 14:39, Ido Schimmel wrote:
> > > > >
> > > > > >
> > > > > > What are "Storm Prevention" and "zero-DPV" FDB entries?
> > > > > >
> > > > >
> > > > > For the zero-DPV entries, I can summarize:
> > > > >
> > > > > Since a CPU can become saturated from constant SA Miss Violations
> > > > > from a
> > > > > denied source, source MAC address are masked by loading a zero-DPV
> > > > > (Destination Port Vector) entry in the ATU. As the address now
> > > > > appears in
> > > > > the database it will not cause more Miss Violations. ANY port trying
> > > > > to send
> > > > > a frame to this unauthorized address is discarded. Any locked port
> > > > > trying to
> > > > > use this unauthorized address has its frames discarded too (as the
> > > > > ports SA
> > > > > bit is not set in the ATU entry).
> > > >
> > > > What happens to unlocked ports that have learning enabled and are trying
> > > > to use this address as SMAC? AFAICT, at least in the bridge driver, the
> > > > locked entry will roam, but will keep the "locked" flag, which is
> > > > probably not what we want. Let's see if we can agree on these semantics
> > > > for a "locked" entry:
> > > 
> > > The next version of this will block forwarding to locked entries in
> > > the
> > > bridge, so they will behave like the zero-DPV entries.
> > 
> > I'm talking about roaming, not forwarding. Let's say you have a locked
> > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
> > from port Z which is unlocked. Will the FDB entry roam to port Z? I
> > think it should, but at least in current implementation it seems that
> > the "locked" flag will not be reset and having locked entries pointing
> > to an unlocked port looks like a bug.
> > 
> 
> Remember that zero-DPV entries blackhole (mask) the MAC, so whenever a
> packet appears with the same MAC on another port it is just dropped in the

What do you mean by "same MAC"? As SMAC or DMAC? I'm talking about SMAC
and when the packet is received via an unlocked port. Why would such a
packet be dropped?

> HW, so there is no possibility of doing any CPU processing in this case.
> Only after the timeout (5 min) can the MAC get a normal ATU on an open port.
> For the bridge to do what you suggest, a FDB search would be needed afaics,
> and this might be in a process sensitive part of the code, thus leading to
> too heavy a cost.

When learning is enabled the bridge already performs a lookup on the
SMAC.

TBH, I don't think this is progressing well because there is too much
discrepancy between how this feature works in the bridge driver and in
the hardware you work with.

I suggest to first define the model in the bridge driver and then take
care of the offload. My suggestion is to send another RFC with only the
bridge changes with emphasize on the following aspects:

* Forwarding rules for "locked" entries. Do they drop matching packets?
Forward them? Or not considered at all for forwarding?

* Roaming rules for "locked" entries. Can they roam between locked
ports? Can they roam from a locked port to an unlocked port and
vice versa? Or are they completely sticky?

* Ageing rule for "locked" entries. Are these entries subject to the
ageing time or are they static? If they are not static, are they
refreshed by incoming traffic from a locked port or not?

* MAB enablement. New option? Overload an existing one? No option?

The commit messages should explain these design choices and new tests
cases should verify the desired behavior.

Once we have an agreement we can work out the switchdev/mv88e6xxx parts
and eventually the entire thing can be merged together. Fair?
