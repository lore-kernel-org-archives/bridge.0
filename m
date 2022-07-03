Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66AE582F20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 052B482F0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXYlR4I7hBAnJ9i4IMa7UUQGvFFzBvopwDjKmtR/h9k=;
 b=KQsAQK8rQdLEAZynuZ68QIsmEvMYtvCinBTf4+S+exO7/8INlKDUyNCqPcYKfyazDrOzgHJBv5EBmaX2lInbOiCT3KRQTDSc0YBq8vlXV0uNJ/nBVzEy1XwICdJlzB0kKfCSxWGXNWlsnxfB3SCsrn7Yu3UINmJ6e7J2VbSDoN28Z5tV2874lsV9bui/LNv9/7DLgq2lIEr6YqZDyrL87/XoEngDl3jk3RJfu2kRRQd0PNdE7224xnW7qlYGkyHjk9R1C3k4GoG6E/AaPcyLfbTOs+/hxSxEriPc0YtwikLb8eydZ92m0GQU3xmuBrF6/4Ceoof0OO2ENhvDy2ii8w==
Date: Sun, 3 Jul 2022 10:00:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YsE+hreRa0REAG3g@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
 <Yr8oPba83rpJE3GV@shredder>
 <CAKUejP4_05E0hfFp-ceXLgPuid=MwrAoHyQ-nYE3qx3Tisb4uA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP4_05E0hfFp-ceXLgPuid=MwrAoHyQ-nYE3qx3Tisb4uA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 09:17:27PM +0200, Hans S wrote:
> On Fri, Jul 1, 2022 at 7:00 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Fri, Jul 01, 2022 at 06:07:10PM +0200, Hans S wrote:
> > > There is several issues when learning is turned off with the mv88e6xxx driver:
> >
> > Please don't top-post...
> 
> Sorry, I am using gmails own web interface for a short while now as my
> other options are not supported anymore by Google (not secure apps)
> 
> >
> > >
> > > Mac-Auth requires learning turned on, otherwise there will be no miss
> > > violation interrupts afair.
> > > Refreshing of ATU entries does not work with learning turn off, as the
> > > PAV is set to zero when learning is turned off.
> > > This then further eliminates the use of the HoldAt1 feature and
> > > age-out interrupts.
> > >
> > > With dynamic ATU entries (an upcoming patch set), an authorized unit
> > > gets a dynamic ATU entry, and if it goes quiet for 5 minutes, it's
> > > entry will age out and thus get removed.
> > > That also solves the port relocation issue as if a device relocates to
> > > another port it will be able to get access again after 5 minutes.
> >
> > You assume I'm familiar with mv88e6xxx, when in fact I'm not. Here is
> > what I think you are saying:
> >
> > 1. When a port is locked and a packet is received with a SA that is not
> > in the FDB, it will only generate a miss violation if learning is
> > enabled. In which case, you will notify the bridge driver about this
> > entry as externally learned and locked entry.
> 
> Right.
> 
> > 2. When a port is locked and a packet is received with a SA that matches
> > a different port, it will be dropped regardless if learning is enabled
> > or not.
> 
> I would think so.
> 
> > 3. From the above I conclude that the HW will not auto-populate its FDB
> > when a port is locked.
> 
> Right, and it should not as the locked port feature is basically CPU
> controlled learning.
> (yes it is an irony to have CPU controlled learning and learning
> turned on, but that is just how it is with the mv88e6xxx series :-) )
> 
> > 4. FDB entries that point to a port that does not have learning enabled
> > are not subject to ageing (why?).
> 
> Sorry if I said so. Dynamic ATU entries will age I am sure, but they
> will not refresh unless there is a match between the ingress port and
> the Port Association Vector (PAV).
> But an age out violation will not occur, and the HoldAt1 (entries age
> from 7 -> 0) feature will not work either as it is related to the
> refresh mechanism.
> 
> >
> > Assuming the above is correct, in order for mv88e6xxx to work correctly,
> > it needs to enable learning on all locked ports, but it should happen
> > regardless of the bridge driver learning configuration let alone impose
> > any limitations on it. In fact, hostapd must disable learning for all
> > locked ports.
> 
> To have hardware induced refreshing I would say learning should be on
> also for 802.1X (hostapd). This relies of course on user added dynamic
> ATU entries, which is what my follow-up patch set is about. Besides it
> is perfectly feasible to have both 802.1X and Mac-Auth on the same
> port.

IIUC, with mv88e6xxx, when the port is locked and learning is disabled:

1. You do not get miss violation interrupts. Meaning, you can't report
'locked' entries to the bridge driver.

2. You do not get aged-out interrupts. Meaning, you can't tell the
bridge driver to remove aged-out entries.

My point is that this should happen regardless if learning is enabled on
the bridge driver or not. Just make sure it is always enabled in
mv88e6xxx when the port is locked. Learning in the bridge driver itself
can be off, thereby eliminating the need to disable learning from
link-local packets.
