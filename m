Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C2E481498
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAF9A8144F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lib8bisyBHrWO6pAcEhBi4DsSbSF2hoDcjmaxglAXEM=;
 b=ui0dcW18C1lOskPdXIAhazeez8bvY/QYLk9w1PeWKjocqkO8+OLDryFslkmjUpN1QS3lSoTntHWY7mT3rEcdE2SxOL9oZoVuaf1BGCuXZRugir2oztAqV8tc31kR1H3+uA8fYfvBC0J8QTMVOZacEGF1p5jELW5mfJgw5U1om6gSW+kgbpPRNvQhOF+IP2W68o/vlg24ByOKOsvToGwJcaygiw67yyA6SdSbeZHuwfUL2tiVORpncESuaxzRgpfU6Rwl7HoJACd70ICLF0JgHsKQdHAX9ys1pMoPAu14qymYffcSjWY3GJ5vm4iMEedwuQH+uvcY1p7PTei7ONxGbw==
Date: Tue, 23 Aug 2022 09:48:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YwR4MQ2xOMlvKocw@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <ce4266571b2b47ae8d56bd1f790cb82a@kapio-technology.com>
 <YwMW4iGccDu6jpaZ@shredder>
 <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2822d6dd66a1239ff8b7bfd06019008@kapio-technology.com>
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

On Mon, Aug 22, 2022 at 09:49:28AM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-22 07:40, Ido Schimmel wrote:
> > On Sun, Aug 21, 2022 at 03:43:04PM +0200, netdev@kapio-technology.com
> > wrote:
> > 
> > I personally think that the mv88e6xxx semantics are very weird (e.g., no
> > roaming, traffic blackhole) and I don't want them to determine how the
> > feature works in the pure software bridge or other hardware
> > implementations. On the other hand, I understand your constraints and I
> > don't want to create a situation where user space is unable to
> > understand how the data path works from the bridge FDB dump with
> > mv88e6xxx.
> > 
> > My suggestion is to have mv88e6xxx report the "locked" entry to the
> > bridge driver with additional flags that describe its behavior in terms
> > of roaming, ageing and forwarding.
> > 
> > In terms of roaming, since in mv88e6xxx the entry can't roam you should
> > report the entry with the "sticky" flag.
> 
> As I am not familiar with roaming in this context, I need to know how the SW
> bridge should behave in this case.

I think I wasn't clear enough. The idea is to make the bridge compatible
with mv88e6xxx in a way that is discoverable by user space by having
mv88e6xxx add the locked entry with flags that describe the hardware
behavior. Therefore, it's not a matter of "how the SW bridge should
behave", but having it behave in a way that matches the offloaded data
path.

From what I was able to understand from you, the "locked" entry cannot
roam at all in mv88e6xxx, which can be described by the "sticky" flag.

> In this I am assuming that roaming is regarding unauthorized entries.

Yes, talking about "locked" entries that are notified by mv88e6xxx to
the bridge.

> In this case, is the roaming only between locked ports or does the
> roaming include that the entry can move to a unlocked port, resulting
> in the locked flag getting removed?

Any two ports. If the "locked" entry in mv88e6xxx cannot move once
installed, then the "sticky" flag accurately describes it.

> 
> > In terms of ageing, since
> > mv88e6xxx is the one doing the ageing and not the bridge driver, report
> > the entry with the "extern_learn" flag.
> 
> Just for the record, I see that entries coming from the driver to the bridge
> will always have the "extern learn" flag set as can be seen from the
> SWITCHDEV_FDB_ADD_TO_BRIDGE events handling in br_switchdev_event() in br.c,
> which I think is the correct behavior.

Yes.

> 
> > In terms of forwarding, in
> > mv88e6xxx the entry discards all matching packets. We can introduce a
> > new FDB flag that instructs the entry to silently discard all matching
> > packets. Like we have with blackhole routes and nexthops.
> 
> Any suggestions to the name of this flag?

I'm not good at naming, but "blackhole" is at least consistent with what
we already have for routes and nexthop objects.

> 
> > 
> > I believe that the above suggestion allows you to fully describe how
> > these entries work in mv88e6xxx while keeping the bridge driver in sync
> > with complete visibility towards user space.
> > 
> > It also frees the pure software implementation from the constraints of
> > mv88e6xxx, allowing "locked" entries to behave like any other
> > dynamically learned entries modulo the fact that they cannot "unlock" a
> > locked port.
> > 
> > Yes, it does mean that user space will get a bit different behavior with
> > mv88e6xxx compared to a pure software solution, but a) It's only the
> > corner cases that act a bit differently. As a whole, the feature works
> > largely the same. b) User space has complete visibility to understand
> > the behavior of the offloaded data path.
> > 
> 
> > > 
> > > I will change it in iproute2 to:
> > > bridge link set dev DEV mab on|off
> > 
> > And s/BR_PORT_MACAUTH/BR_PORT_MAB/ ?
> 
> Sure, I will do that. :-)

Thanks
