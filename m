Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TOTLPcNR5PDvz2xr0KET/zWPPjKon9laHgi22gTIanA=;
	b=Ob5SvMYFf1wJPi4F8eWeXtIE1JznAzxXcK4AAlcHVteYFnOtngKjHXEHabAdexCVam
	163jWF4jeD6rnpy23MxcgMMDBSLeo93lPJA9yJz25fNCMhxOM5NoP2i16oyp/khwGgpg
	YKZe8xoW28rxGP3aglql85LCBvHaVwd+wXoiTPEGSmKKffESJC9Ua0S2FXkAJs8neYJ/
	HG1oCdONCLsssk+3YiRwQcIQwQ/FY7/bXZffdD0NjN02C7rk+Rv+CSkDyTu6MHH8U/+P
	I8hUnwe9j+mHNLmpjYoqdOE3+9gsOdshQaC9o+igpXpGBdlWh1T1L6/IqQoydOVm33ag
	DSiQ==
References: <cover.1527173527.git.petrm@mellanox.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com>
Date: Thu, 24 May 2018 10:20:46 -0700
MIME-Version: 1.0
In-Reply-To: <cover.1527173527.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Hi Petr,

On 05/24/2018 08:09 AM, Petr Machata wrote:
> In commit 946a11e7408e ("mlxsw: spectrum_span: Allow bridge for gretap
> mirror"), mlxsw got support for offloading mirror-to-gretap such that
> the underlay packet path involves a bridge. In that case, the offload is
> also influenced by PVID setting of said bridge. However, changes to VLAN
> configuration of the bridge itself do not generate switchdev
> notifications, so there's no mechanism to prod mlxsw to update the
> offload when these settings change.
> 
> In this patchset, the problem is resolved by distributing the switchdev
> notification SWITCHDEV_OBJ_ID_PORT_VLAN also for configuration changes
> on bridge VLANs. Since stacked devices distribute the notification to
> lower devices, such event eventually reaches the driver, which can
> determine whether it's a bridge or port VLAN by inspecting orig_dev.
> 
> To keep things consistent, the newly-distributed notifications observe
> the same protocol as the existing ones: dual prepare/commit, with
> -EOPNOTSUPP indicating lack of support, even though there's currently
> nothing to prepare for and nothing to support. Correspondingly, all
> switchdev drivers have been updated to return -EOPNOTSUPP for bridge
> VLAN notifications.

You seem to have approached the bridge changes a little differently from
this series:

https://lists.linux-foundation.org/pipermail/bridge/2016-November/010112.html

Both have the same intent that by targeting the bridge device itself,
you can propagate that through switchdev to the switch drivers, and in
turn create configurations where for instance, you have:

- CPU/management port present in specific VLANs that is a subset or
superset of the VLANs configured on front-panel ports
- CPU/management port tagged/untagged in specific VLANs which can be a
different setting from the front-panel ports

One problem we have in DSA at the moment is that we always add the CPU
port to the VLANs configured to the front-panel port but we do this with
the same attributes as the front panel ports! For instance, if you add
Port 0 to VLAN1 untagged, the the CPU port also gets added to that
VLAN1, also untagged. As long as there is just one VLAN untagged, this
is not much of a problem. Now do this with another VLAN or another port,
and the CPU can no longer differentiate the traffic from which VLAN it
is coming from, no bueno.

I had specifically changed b53 to always add the CPU port as tagged,
because that would always allow for differentiating traffic, but I would
rather have the capability to configure that at the bridge layer, which
you series seem to allow.

For the record, here is what the first commit in the series intended to
let an user do:

The following happens now (assuming bridge master device is already
created):

bridge vlan add vid 2 dev port0 pvid untagged
	-> port0 (e.g: switch port 0) gets programmed
	-> CPU port gets programmed
bridge vlan add vid 2 dev br0 self
	-> CPU port gets programmed
bridge vlan add vid 2 dev port0
	-> port0 (switch port 0) gets programmed

Are these use cases possible with your series? It seems to me like it is
if we drop the netif_is_bridge_master() checks and resolve orig_dev as
being a hint for the CPU/management port.

Thanks for reading me :)

> 
> In patch #1, the code to send notifications for adding and deleting is
> factored out into two named functions.
> 
> In patches #2-#5, respectively for mlxsw, rocker, DSA and DPAA2 ethsw,
> the new notifications (which are not enabled yet) are ignored to
> maintain the current behavior.
> 
> In patch #6, the notification is actually enabled.
> 
> In patch #7, mlxsw is changed to update offloads of mirror-to-gre also
> for bridge-related notifications.
> 
> Petr Machata (7):
>   net: bridge: Extract boilerplate around switchdev_port_obj_*()
>   mlxsw: spectrum_switchdev: Ignore bridge VLAN events
>   rocker: rocker_main: Ignore bridge VLAN events
>   dsa: port: Ignore bridge VLAN events
>   staging: fsl-dpaa2: ethsw: Ignore bridge VLAN events
>   net: bridge: Notify about bridge VLANs
>   mlxsw: spectrum_switchdev: Schedule respin during trans prepare
> 
>  .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  8 ++-
>  drivers/net/ethernet/rocker/rocker_main.c          |  6 +++
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |  6 +++
>  net/bridge/br_vlan.c                               | 58 ++++++++++++++--------
>  net/dsa/port.c                                     |  6 +++
>  5 files changed, 62 insertions(+), 22 deletions(-)
> 


-- 
Florian
