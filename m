Message-ID: <4141AC53.1000102@siennax.com>
Date: Fri, 10 Sep 2004 15:29:55 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Problem in changed VLAN code can cause systems to hang.
References: <414057B1.1020902@siennax.com>	<1094820204.32553.67.camel@cyan.cph.tpack.net>
	<20040910061424.29657cf3@linux.site>
In-Reply-To: <20040910061424.29657cf3@linux.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, bridge@lists.osdl.org, netdev@premium.geo.yahoo.akadns.net, Tommy Christensen <tommy.christensen@tpack.net>

Stephen Hemminger wrote:
> Thanks Tommy, the vlan MII ioctl pass through was passing the wrong device.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> --
> diff -Nru a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> --- a/net/8021q/vlan_dev.c	2004-09-10 06:12:16 -07:00
> +++ b/net/8021q/vlan_dev.c	2004-09-10 06:12:16 -07:00
> @@ -772,7 +772,7 @@
>  	case SIOCGMIIREG:
>  	case SIOCSMIIREG:
>  		if (real_dev->do_ioctl && netif_device_present(real_dev)) 
> -			err = real_dev->do_ioctl(dev, &ifrr, cmd);
> +			err = real_dev->do_ioctl(real_dev, &ifrr, cmd);
>  		break;
>  
>  	case SIOCETHTOOL:
> 

I tested the patch and it fixes the problem as expected.

Mark.

-- 

