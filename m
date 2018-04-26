Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Bh6NdFRNVnfbMo0Ewb85z+0+Yaf6eJeuCVEGovuED/U=;
	b=mGXA3Xj9dSa5NnTZNxukyU6o8XFzJ/mXd4oH7kRNNj3W8CHRuTSt98fGAUfkodqlJM
	5+I1wz930cW42onfXhKtYQYgBBfnyrMPECgdiwavu+J0Gn8dd77HkbY/FNwtNA9OjzXw
	rJbu8AuCtJeFXL5xCdffhIc2lGR/Ku8Owah4z3mVgAYObrbN65LYHXL5J4+BVe7iMdbZ
	cQxm0vcpMICYMp5qW63RKiUpGURJoHRe67cvUEQsoxzGxF3wofTiXzB4BQa5tDCP/i9Q
	x9kgUKRSmbk193PKaVEZmSPBPUJRGFu6qGqO0laKEXNVo6hsbHNP3S4kS6h1aaoCMFc/
	0X4w==
Date: Thu, 26 Apr 2018 08:58:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180426085833.2fbcd276@xeon-e3>
In-Reply-To: <1e3e120f-821a-2d99-b720-0585ce9c1803@cumulusnetworks.com>
References: <20180426090637.25262-1-idosch@mellanox.com>
	<20180426090637.25262-7-idosch@mellanox.com>
	<1e3e120f-821a-2d99-b720-0585ce9c1803@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/6] mlxsw: spectrum_span: Allow
 bridge for gretap mirror
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: mlxsw@mellanox.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

On Thu, 26 Apr 2018 13:50:12 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> On 26/04/18 12:06, Ido Schimmel wrote:
> > From: Petr Machata <petrm@mellanox.com>
> > 
> > When handling mirroring to a gretap or ip6gretap netdevice in mlxsw, the
> > underlay address (i.e. the remote address of the tunnel) may be routed
> > to a bridge.
> > 
> > In that case, look up the resolved neighbor Ethernet address in that
> > bridge's FDB. Then configure the offload to direct the mirrored traffic
> > to that port, possibly with tagging.
> > 
> > Signed-off-by: Petr Machata <petrm@mellanox.com>
> > Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> > ---
> >   .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 102 +++++++++++++++++++--
> >   .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |   1 +
> >   2 files changed, 97 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > index 65a77708ff61..92fb81839852 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > @@ -32,6 +32,7 @@
> >    * POSSIBILITY OF SUCH DAMAGE.
> >    */
> >   
> > +#include <linux/if_bridge.h>
> >   #include <linux/list.h>
> >   #include <net/arp.h>
> >   #include <net/gre.h>
> > @@ -39,8 +40,9 @@
> >   #include <net/ip6_tunnel.h>
> >   
> >   #include "spectrum.h"
> > -#include "spectrum_span.h"
> >   #include "spectrum_ipip.h"
> > +#include "spectrum_span.h"
> > +#include "spectrum_switchdev.h"
> >   
> >   int mlxsw_sp_span_init(struct mlxsw_sp *mlxsw_sp)
> >   {
> > @@ -167,6 +169,79 @@ mlxsw_sp_span_entry_unoffloadable(struct mlxsw_sp_span_parms *sparmsp)
> >   	return 0;
> >   }
> >   
> > +static struct net_device *
> > +mlxsw_sp_span_entry_bridge_8021q(const struct net_device *br_dev,
> > +				 unsigned char *dmac,
> > +				 u16 *p_vid)
> > +{
> > +	struct net_bridge_vlan_group *vg = br_vlan_group_rtnl(br_dev);
> > +	u16 pvid = br_vlan_group_pvid(vg);
> > +	struct net_device *edev = NULL;
> > +	struct net_bridge_vlan *v;
> > +  
> 
> Hi,
> These structures are not really exported anywhere outside of br_private.h
> Instead of passing them around and risking someone else actually trying to
> dereference an incomplete type, why don't you add just 2 new helpers -
> br_vlan_pvid(netdevice) and br_vlan_info(netdevice, vid, *bridge_vlan_info)
> 
> br_vlan_info can return the exported and already available type "bridge_vlan_info"
> (defined in uapi/linux/if_bridge.h) into the bridge_vlan_info arg
> and br_vlan_pvid is obvious - return the current dev pvid if available.
> 
> Another bonus you'll avoid dealing with the bridge's vlan internals.

I am particularly worried that any locking changes will impact the device
driver. Also lock inversion issues, and implied (or not RTNL).
Also what if a value is changed, there is no notification path back to the device.

Having an API that only takes net_device and vlan seems preferable.
