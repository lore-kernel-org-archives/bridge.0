Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1hm0U8iqrNA2AC4S5A+hJ5u9oXabFq08f+wUuwcGTiA=;
	b=U+kaQmM5FbAFNTpIDQFoQU8tHKqgointvQOy9nWgGT1YRIELSQgtbug9GN6XBUfgro
	chr5GKorh/vHOcy1PCiUEOsZLCBjV4LOfVnO9I8nq+HRA1/laQJZZcXEABMeqU8sITKN
	UesULtxD2XjZpeyerfeJFE8xP6Ic0f9e3y+8zl60lcAoHTYTmBPtBohmpPWi9y37otw5
	QduqRxWC7zx1NQBKcbwwiNYQNw/iNEuBZNxmvP0aBLvL4lADl1nux0VUmwXqqbLPA0+p
	CYGvtaYgDvGKSyHfFTKLufbemyYudTvnw0a8gNGdycjt0t8NT1SEEhZm3FLqpths7HQB
	ktSw==
Date: Thu, 21 Sep 2017 08:15:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170921081542.4c266c83@xeon-e3>
In-Reply-To: <20170921100525.20395-1-vincent@bernat.im>
References: <20170920162140.369bb198@xeon-e3>
	<20170921100525.20395-1-vincent@bernat.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [net-next v3] bridge: trigger RTM_NEWLINK when
 interface is modified by bridge ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>

On Thu, 21 Sep 2017 12:05:25 +0200
Vincent Bernat <vincent@bernat.im> wrote:

> Currently, there is a difference in netlink events received when an
> interface is modified through bridge ioctl() or through netlink. This
> patch generates additional events when an interface is added to or
> removed from a bridge via ioctl().
> 
> When adding then removing an interface from a bridge with netlink, we
> get:
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> When using ioctl():
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue master bridge0 state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> Deleted 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
>     link/ether 9e:da:60:ee:cf:c8
> 5: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
>     link/ether 9e:da:60:ee:cf:c8 brd ff:ff:ff:ff:ff:ff
> 
> Without this patch, the last netlink notification is not sent.
> 
> Signed-off-by: Vincent Bernat <vincent@bernat.im>

This makes sense, you should probably add a Fixes: tag to help maintainers
of long term stable kernels.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

