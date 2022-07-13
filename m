Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AC7041B59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2FD541B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORd5OE6IejCWSajkAb9baeZu3snvfbor2sPsyw37s7M=;
 b=LfNvPxKtRCCWWZopRfp4ep8hAmwxEA3+I8t9kHfFjUhNOuYi76FSBAilxuqt51+rQO82+Y1lVPdxvH0Jx1iA5T5r1cBPfI9dSFZeK/tLncuQMrDv68lYwphriLXbbCxmyNvAuvxsYkGTJcrXuof17sRvwFRakJBk8p994rPz4V59mg4Vu7CHDB0I4gyxECz6UMC6ZdIfA9xH0iHHoExw0wsW7fVHVYS1HjEEs7v5mMMILw0MCRdSpfo7urPkQPRUfdelyq5i4mHuOVm/0zRguPe38f7jPJHmtfNq7zYXHVsU/cXA5ykmGCjL/BwS3WejG6l0FxsrwkXhSJCTvAHH0g==
Date: Wed, 13 Jul 2022 15:39:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ys69DiAwT0Md+6ai@shredder>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
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

On Wed, Jul 13, 2022 at 09:09:58AM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-10 10:35, Ido Schimmel wrote:
> > On Fri, Jul 08, 2022 at 02:34:25PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-07-08 13:56, Vladimir Oltean wrote:
> > > > On Fri, Jul 08, 2022 at 11:50:33AM +0200, netdev@kapio-technology.com
> > > > wrote:
> > > > > On 2022-07-08 11:15, Vladimir Oltean wrote:
> > > > > > When the possibility for it to be true will exist, _all_ switchdev
> > > > > > drivers will need to be updated to ignore that (mlxsw, cpss, ocelot,
> > > > > > rocker, prestera, etc etc), not just DSA. And you don't need to
> > > > > > propagate the is_locked flag to all individual DSA sub-drivers when none
> > > > > > care about is_locked in the ADD_TO_DEVICE direction, you can just ignore
> > > > > > within DSA until needed otherwise.
> > > > > >
> > > > >
> > > > > Maybe I have it wrong, but I think that Ido requested me to send it
> > > > > to all
> > > > > the drivers, and have them ignore entries with is_locked=true ...
> > > >
> > > > I don't think Ido requested you to ignore is_locked from all DSA
> > > > drivers, but instead from all switchdev drivers maybe. Quite different.
> > > 
> > > So without changing the signature on port_fdb_add(). If that is to
> > > avoid
> > > changing that signature, which needs to be changed anyhow for any
> > > switchcore
> > > driver to act on it, then my next patch set will change the
> > > signarure also
> > > as it is needed for creating dynamic ATU entries from userspace,
> > > which is
> > > needed to make the whole thing complete.
> > > 
> > > As it is already done (with the is_locked to the drivers) and needed
> > > for
> > > future application, I would like Ido to comment on it before I take
> > > action.
> > 
> > It's related to my reply here [1]. AFAICT, we have two classes of device
> > drivers:
> > 
> > 1. Drivers like mv88e6xxx that report locked entries to the bridge
> > driver via 'SWITCHDEV_FDB_ADD_TO_BRIDGE'.
> > 
> > 2. Drivers like mlxsw that trap packets that incurred an FDB miss to the
> > bridge driver. These packets will cause the bridge driver to emit
> > 'SWITCHDEV_FDB_ADD_TO_DEVICE' notifications with the locked flag.
> > 
> > If we can agree that locked entries are only meant to signal to user
> > space that a certain MAC tried to gain authorization and that the bridge
> > should ignore them while forwarding, then there is no point in
> > generating the 'SWITCHDEV_FDB_ADD_TO_DEVICE' notifications. We should
> > teach the bridge driver to suppress these so that there is no need to
> > patch all the device drivers.
> 
> I do not know of all about what other switchcores there are and how they
> work, but those that I have knowledge of, it has been prudent in connection
> with the locked port feature to install Storm Prevention or zero-DPV
> (Destination Port Vector) FDB entries.

What are "Storm Prevention" and "zero-DPV" FDB entries?

> I would think that that should be the case for other switchcores too.
> Those entries cannot normally be installed from userspace (of course special
> tools can do anything).
> 
> But if the decision is to drop locked entries at the DSA layer, I can do
> that. I just want to ensure that all considerations have been taken.

There is no decision that I'm aware of. I'm simply trying to understand
how FDB entries that have 'BR_FDB_ENTRY_LOCKED' set are handled in
mv88e6xxx and other devices in this class. We have at least three
different implementations to consolidate:

1. The bridge driver, pure software forwarding. The locked entry is
dynamically created by the bridge. Packets received via the locked port
with a SA corresponding to the locked entry will be dropped, but will
refresh the entry. On the other hand, packets with a DA corresponding to
the locked entry will be forwarded as known unicast through the locked
port.

2. Hardware implementations like Spectrum that can be programmed to trap
packets that incurred an FDB miss. Like in the first case, the locked
entry is dynamically created by the bridge driver and also aged by it.
Unlike in the first case, since this entry is not present in hardware,
packets with a DA corresponding to the locked entry will be flooded as
unknown unicast.

3. Hardware implementations like mv88e6xxx that fire an interrupt upon
FDB miss. Need your help to understand how the above works there and
why. Specifically, how locked entries are represented in hardware (if at
all) and what is the significance of not installing corresponding
entries in hardware.

> 
> > 
> > [1] https://lore.kernel.org/netdev/YsqLyxTRtUjzDj6D@shredder/
> > 
> > > 
> > > >
> > > > In any case I'm going to take a look at this patch set more closely and
> > > > run the selftest on my Marvell switch, but I can't do this today
> > > > unfortunately. I'll return with more comments.
> > > 
> > > Yes :-)
