Subject: Re: [Bridge] Problem in changed VLAN code can cause systems to hang.
From: Tommy Christensen <tommy.christensen@tpack.net>
In-Reply-To: <414057B1.1020902@siennax.com>
References: <414057B1.1020902@siennax.com>
Content-Type: text/plain
Message-Id: <1094820204.32553.67.camel@cyan.cph.tpack.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Fri, 10 Sep 2004 12:43:32 -0000
To: Mark Ruijter <bridge@siennax.com>
Cc: "David S. Miller" <davem@redhat.com>, bridge@lists.osdl.org, Stephen Hemminger <shemminger@osdl.org>

On Thu, 2004-09-09 at 15:16, Mark Ruijter wrote:
>                  if (real_dev->do_ioctl && netif_device_present(real_dev))
>                          err = real_dev->do_ioctl(dev, &ifrr, cmd);

I guess do_ioctl should be called with real_dev as parameter here.

-Tommy


