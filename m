Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 6 Jun 2014 08:50:12 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20140606155012.GA15110@kroah.com>
References: <1402047743-3391-1-git-send-email-kenhelias@firemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402047743-3391-1-git-send-email-kenhelias@firemail.de>
Subject: Re: [Bridge] [PATCH] list: Fix order of arguments for
	hlist_add_after(_rcu)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ken Helias <kenhelias@firemail.de>
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On Fri, Jun 06, 2014 at 11:42:23AM +0200, Ken Helias wrote:
> All other add functions for lists have the new item as first argument and the
> position where it is added as second argument. This was changed for no good
> reason in this function and makes using it unnecessary confusing.
> 
> Also the naming of the arguments in hlist_add_after was confusing. It was
> changed to use the same names as hlist_add_after_rcu.
> 
> Signed-off-by: Ken Helias <kenhelias@firemail.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Bruce Allan <bruce.w.allan@intel.com>
> Cc: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Cc: Don Skidmore <donald.c.skidmore@intel.com>
> Cc: Greg Rose <gregory.v.rose@intel.com>
> Cc: Alex Duyck <alexander.h.duyck@intel.com>
> Cc: John Ronciak <john.ronciak@intel.com>
> Cc: Mitch Williams <mitch.a.williams@intel.com>
> Cc: Linux NICS <linux.nics@intel.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Dipankar Sarma <dipankar@in.ibm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <antonio@meshcoding.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: dri-devel@lists.freedesktop.org
> Cc: e1000-devel@lists.sourceforge.net
> Cc: netdev@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: b.a.t.m.a.n@lists.open-mesh.org
> Cc: bridge@lists.linux-foundation.org
> ---
> Patch based on "Add linux-next specific files for 20140606"
> 
>  drivers/gpu/drm/drm_hashtab.c                    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  2 +-
>  drivers/staging/lustre/lustre/libcfs/hash.c      |  4 ++--
>  fs/namespace.c                                   |  2 +-
>  fs/notify/inode_mark.c                           |  2 +-
>  fs/notify/vfsmount_mark.c                        |  2 +-
>  include/linux/list.h                             | 12 ++++++------
>  include/linux/rculist.h                          |  6 +++---
>  net/batman-adv/fragmentation.c                   |  2 +-
>  net/bridge/br_multicast.c                        |  2 +-
>  net/ipv4/fib_trie.c                              |  2 +-
>  net/ipv6/addrlabel.c                             |  2 +-
>  net/xfrm/xfrm_policy.c                           |  4 ++--
>  14 files changed, 23 insertions(+), 23 deletions(-)


drivers/staging/ portion:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
