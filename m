Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 898C360AC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2B8360888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNMMKE0TtKx3v/Z85KrxgERvP1I9hgJEE5AmlDHoavw=;
 b=nviudDU7ogCBuPg3K3HxuATbvqN8FgfW443qX3yzbzjKKTQJfuAA7l7TIl0pNh/kL2trEZ2rP7qYvPpNs3f/t/B6KQ3AX0F5Lh4IyxM8RSnkqeNqKgGb1j1F+l88pqCdH16b0t19xKcKmD4g4qwSq12+kYhgmTCD0QkL3TNS930pEhY8y2+X94kajbQdAUs9eserK26nQ+wE7akihUXwYOfbl5QoG2x/+vI1XT3WO3p6dTmaKfgeiQGJieuz+fuYaYpja3v7TB2o8oWK50EuNp4z47HxCFvj5iqNUavqbBsvvSugh2O3nyYnXemlPPkzeJguQre2PY6zOgkp4ZqH3g==
Date: Sun, 6 Nov 2022 15:21:16 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y2e0zHgzIClULTIB@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <e6c4c3755e4aba80b3c7ebf31c8cdb58@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c4c3755e4aba80b3c7ebf31c8cdb58@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 00/16] bridge: Add MAC
 Authentication Bypass (MAB) support with offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Sun, Nov 06, 2022 at 01:04:36PM +0100, netdev@kapio-technology.com wrote:
> On 2022-10-25 12:00, Ido Schimmel wrote:
> > Merge plan
> > ==========
> > 
> > We need to agree on a merge plan that allows us to start submitting
> > patches for inclusion and finally conclude this work. In my experience,
> > it is best to work in small batches. I therefore propose the following
> > plan:
> > 
> > * Add MAB support in the bridge driver. This corresponds to patches
> >   #1-#2.
> > 
> > * Switchdev extensions for MAB offload together with mlxsw
> >   support. This corresponds to patches #3-#16. I can reduce the number
> >   of patches by splitting out the selftests to a separate submission.
> > 
> > * mv88e6xxx support. I believe the blackhole stuff is an optimization,
> >   so I suggest getting initial MAB offload support without that. Support
> >   for blackhole entries together with offload can be added in a separate
> >   submission.
> 
> As I understand for the mv88e6xxx support, we will be sending
> SWITCHDEV_FDB_ADD_TO_BRIDGE
> events from the driver to the bridge without installing entries in the
> driver.
> Just to note, that will of course imply that the bridge FDB will be out of
> sync with the
> FDB in the driver (ATU).

Stated explicitly here:
https://lore.kernel.org/netdev/20221025100024.1287157-4-idosch@nvidia.com/

Don't see a way around it and it's not critical IMO. The entries will
not appear with the "offload" flag so user space knows they are not in
hardware. Once the "blackhole" flag is supported, user space can replace
such entries and set the "blackhole" flag, which will result in the
entries being programmed to hardware (assuming hardware/driver support).

I plan to submit the offload patches later this week.
