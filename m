Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4F82600CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C5860A72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLLxvZksRetjwjdMPvziNPMzngEJk9Xp2s7sxduq0Wg=;
 b=uM/4E7fPp7cGxVPjrF+c55MHzEZxvbJPzPj/RfPYuGNuBbeW6M46S9VcOiN6jFZMwUt+xF110oa8BV7q33LroJolBPQWMTOzcfmFTkmy5xWOEWK6KcoGdzN0F4WoY8jWvZJPVxhVwEWHkUYXVOR+4u9mzaGpHVy11J3Gb8hts2bhrz+4jPPv+l8wzr/79F/0GutibbVbegCBC+HdHW9FfnIBtBA271cMskXbTPqHCuSAHDGb8lsyWYK0wHxB+VsVNUZRZMh59giddqevC/ukYJiEjyxozUIgdxkiCelDfi9fX6gZMVDkToAVbdfPFVR+Ec5F16hLYkB4OW3mjscHJA==
Date: Sun, 30 Oct 2022 11:25:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y15C7Uq0OoMTTv1G@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-4-idosch@nvidia.com>
 <20221027231039.2rqn7yeomk5nsx76@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027231039.2rqn7yeomk5nsx76@skbuf>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 03/16] bridge: switchdev: Let
 device drivers determine FDB offload indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "ivecera@redhat.com" <ivecera@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "roopa@nvidia.com" <roopa@nvidia.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>, "mlxsw@nvidia.com" <mlxsw@nvidia.com>, "jiri@nvidia.com" <jiri@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>

On Thu, Oct 27, 2022 at 11:10:41PM +0000, Vladimir Oltean wrote:
> On Tue, Oct 25, 2022 at 01:00:11PM +0300, Ido Schimmel wrote:
> > Currently, FDB entries that are notified to the bridge via
> > 'SWITCHDEV_FDB_ADD_TO_BRIDGE' are always marked as offloaded. With MAB
> > enabled, this will no longer be universally true. Device drivers will
> > report locked FDB entries to the bridge to let it know that the
> > corresponding hosts required authorization, but it does not mean that
> > these entries are necessarily programmed in the underlying hardware.
> > 
> > Solve this by determining the offload indication based of the
> > 'offloaded' bit in the FDB notification.
> > 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> > 
> > Notes:
> >     Needs auditing to see which device drivers are not setting this bit.
> > 
> >  net/bridge/br.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > index 96e91d69a9a8..145999b8c355 100644
> > --- a/net/bridge/br.c
> > +++ b/net/bridge/br.c
> > @@ -172,7 +172,7 @@ static int br_switchdev_event(struct notifier_block *unused,
> >  			break;
> >  		}
> >  		br_fdb_offloaded_set(br, p, fdb_info->addr,
> > -				     fdb_info->vid, true);
> > +				     fdb_info->vid, fdb_info->offloaded);
> 
> ofdpa_port_fdb_learn_work() doesn't set info->offloaded on
> SWITCHDEV_FDB_ADD_TO_BRIDGE, the rest do.

Double-checked and this is the only one missing. Will send a patch.
Thanks

> 
> >  		break;
> >  	case SWITCHDEV_FDB_DEL_TO_BRIDGE:
> >  		fdb_info = ptr;
> > -- 
> > 2.37.3
> >
