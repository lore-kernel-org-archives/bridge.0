Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1513711994.7000.220.camel@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 19 Dec 2017 21:33:14 +0200
In-Reply-To: <978985b0-1580-ab62-1dc6-127dac4a1620@infradead.org>
References: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
	<978985b0-1580-ab62-1dc6-127dac4a1620@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1] bridge: Use helpers to handle MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On Tue, 2017-12-19 at 11:21 -0800, Randy Dunlap wrote:
> On 12/19/2017 10:10 AM, Andy Shevchenko wrote:
> > Use
> > 	%pM to print MAC
> > 	mac_pton() to convert it from ASCII to binary format, and
> > 	ether_addr_copy() to copy.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (same)
> 	select GENERIC_NET_UTILS
> ?

(same)

Done by CONFIG_NET.

> 
> > ---
> >  net/bridge/br_sysfs_br.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> > index 723f25eed8ea..b1be0dcfba6b 100644
> > --- a/net/bridge/br_sysfs_br.c
> > +++ b/net/bridge/br_sysfs_br.c
> > @@ -272,10 +272,7 @@ static ssize_t group_addr_show(struct device
> > *d,
> >  			       struct device_attribute *attr, char
> > *buf)
> >  {
> >  	struct net_bridge *br = to_bridge(d);
> > -	return sprintf(buf, "%x:%x:%x:%x:%x:%x\n",
> > -		       br->group_addr[0], br->group_addr[1],
> > -		       br->group_addr[2], br->group_addr[3],
> > -		       br->group_addr[4], br->group_addr[5]);
> > +	return sprintf(buf, "%pM\n", br->group_addr);
> >  }
> >  
> >  static ssize_t group_addr_store(struct device *d,
> > @@ -284,14 +281,11 @@ static ssize_t group_addr_store(struct device
> > *d,
> >  {
> >  	struct net_bridge *br = to_bridge(d);
> >  	u8 new_addr[6];
> > -	int i;
> >  
> >  	if (!ns_capable(dev_net(br->dev)->user_ns, CAP_NET_ADMIN))
> >  		return -EPERM;
> >  
> > -	if (sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> > -		   &new_addr[0], &new_addr[1], &new_addr[2],
> > -		   &new_addr[3], &new_addr[4], &new_addr[5]) != 6)
> > +	if (!mac_pton(buf, new_addr))
> >  		return -EINVAL;
> >  
> >  	if (!is_link_local_ether_addr(new_addr))
> > @@ -306,8 +300,7 @@ static ssize_t group_addr_store(struct device
> > *d,
> >  		return restart_syscall();
> >  
> >  	spin_lock_bh(&br->lock);
> > -	for (i = 0; i < 6; i++)
> > -		br->group_addr[i] = new_addr[i];
> > +	ether_addr_copy(br->group_addr, new_addr);
> >  	spin_unlock_bh(&br->lock);
> >  
> >  	br->group_addr_set = true;
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
