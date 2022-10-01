Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9C7983EDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A161983E6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyKks1BOcDw6FiARq/bviVPjXI8r6mHUo7uFPUGgDiM=;
 b=HTySrFSDXTDsAakvTPk2v02Ivu0mzS9B1NbkFM7vpfU9wZB4rjzPCM9q3zGunu4DYfuKveTd/K/2BDXdAQ5O4QSGhS1FsJWUiLefI4LBXDdEmaV+/7PZMAAe+z+R+WC5Y8pBM9XBlZwxYT0mZ9KYJFY5HXQWi36WbkWgN94dr8u4Ld+6UvUARDdi8Kp8PHXLxelDSH1QSRgLB+87npOrzMd92CE8L0P67Y2TdX0zNrGAd13PrwhngB0YH76AXlvZ7RgV19mja3AtjHnN7COoo4Ap0f4eANkviFf20NMzqnZt88n4F+tYFsaYtuPHBVG0z5VxhyVUdFLFhi4JXhwT5A==
Date: Sat, 1 Oct 2022 18:38:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YzhfDgqjBvhqNUHX@shredder>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
 <20220929152137.167626-2-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929152137.167626-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH iproute2-next 2/2] bridge: fdb: enable FDB
 blackhole feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, Sep 29, 2022 at 05:21:37PM +0200, Hans Schultz wrote:
> Block traffic to a specific host with the command:
> bridge fdb add <MAC> vlan <vid> dev br0 blackhole

Please add an example with regular and JSON output.

> 
> The blackhole FDB entries can be added, deleted and replaced with
> ordinary FDB entries.
> 
> Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
> ---
>  bridge/fdb.c                   | 7 ++++++-
>  include/uapi/linux/neighbour.h | 4 ++++
>  man/man8/bridge.8              | 6 ++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/bridge/fdb.c b/bridge/fdb.c
> index 0fbe9bd3..2160f1c2 100644
> --- a/bridge/fdb.c
> +++ b/bridge/fdb.c
> @@ -38,7 +38,7 @@ static void usage(void)
>  	fprintf(stderr,
>  		"Usage: bridge fdb { add | append | del | replace } ADDR dev DEV\n"
>  		"              [ self ] [ master ] [ use ] [ router ] [ extern_learn ]\n"
> -		"              [ sticky ] [ local | static | dynamic ] [ vlan VID ]\n"
> +		"              [ sticky ] [ local | static | dynamic ] [blackhole] [ vlan VID ]\n"

[ blackhole ]

>  		"              { [ dst IPADDR ] [ port PORT] [ vni VNI ] | [ nhid NHID ] }\n"
>  		"	       [ via DEV ] [ src_vni VNI ]\n"
>  		"       bridge fdb [ show [ br BRDEV ] [ brport DEV ] [ vlan VID ]\n"
> @@ -116,6 +116,9 @@ static void fdb_print_flags(FILE *fp, unsigned int flags, __u8 ext_flags)
>  	if (flags & NTF_STICKY)
>  		print_string(PRINT_ANY, NULL, "%s ", "sticky");
>  
> +	if (ext_flags & NTF_EXT_BLACKHOLE)
> +		print_string(PRINT_ANY, NULL, "%s ", "blackhole");
> +
>  	if (ext_flags & NTF_EXT_LOCKED)
>  		print_string(PRINT_ANY, NULL, "%s ", "locked");
>  
> @@ -493,6 +496,8 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
>  			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
>  		} else if (matches(*argv, "sticky") == 0) {
>  			req.ndm.ndm_flags |= NTF_STICKY;
> +		} else if (matches(*argv, "blackhole") == 0) {
> +			ext_flags |= NTF_EXT_BLACKHOLE;
>  		} else {
>  			if (strcmp(*argv, "to") == 0)
>  				NEXT_ARG();
> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index 4dda051b..cc7d540e 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -54,6 +54,7 @@ enum {
>  /* Extended flags under NDA_FLAGS_EXT: */
>  #define NTF_EXT_MANAGED		(1 << 0)
>  #define NTF_EXT_LOCKED		(1 << 1)
> +#define NTF_EXT_BLACKHOLE	(1 << 2)
>  
>  /*
>   *	Neighbor Cache Entry States.
> @@ -91,6 +92,9 @@ enum {
>   * NTF_EXT_LOCKED flagged FDB entries are placeholder entries used with the
>   * locked port feature, that ensures that an entry exists while at the same
>   * time dropping packets on ingress with src MAC and VID matching the entry.
> + *
> + * NTF_EXT_BLACKHOLE flagged FDB entries ensure that no forwarding is allowed
> + * from any port to the destination MAC, VID pair associated with it.
>   */
>  
>  struct nda_cacheinfo {
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index 40250477..af2e7db2 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -699,6 +699,12 @@ controller learnt dynamic entry. Kernel will not age such an entry.
>  - this entry will not change its port due to learning.
>  .sp

Need to patch the "SYNOPSIS" section as well

>  
> +.B blackhole
> +- this is an entry that denies all forwarding from any port to a destination
> +matching the entry. It can be added by userspace, but the flag is mostly set
> +from a hardware driver.

I'm not sure the last sentence belongs in the man page. We have no way
of knowing if it is true and it can change with time.

How about:

"this entry will silently discard all matching packets. The entry must
be added as a local permanent entry."

> +.sp
> +
>  .in -8
>  The next command line parameters apply only
>  when the specified device
> -- 
> 2.34.1
> 
