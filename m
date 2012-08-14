Return-Path: <fbl@redhat.com>
From: Flavio Leitner <fbl@redhat.com>
Message-ID: <20120814101400.0ef7aaa9@obelix.rh>
In-Reply-To: <20120814122433.GB1661@minipsycho.brq.redhat.com>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-2-git-send-email-jiri@resnulli.us>
	<20120813145217.38748c4f@obelix.rh>
	<20120814122433.GB1661@minipsycho.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net-next 01/16] net: introduce upper device
	lists
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 13:14:23 -0000
To: Jiri Pirko <jiri@resnulli.us>
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, linux-driver@qlogic.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, gregory.v.rose@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

On Tue, 14 Aug 2012 14:24:33 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Mon, Aug 13, 2012 at 07:52:17PM CEST, fbl@redhat.com wrote:
> >On Mon, 13 Aug 2012 17:27:00 +0200
> >Jiri Pirko <jiri@resnulli.us> wrote:
> >> +	/*
> >> +	 * To prevent loops, check if dev is not upper device to upper_dev.
> >> +	 */
> >> +	if (__netdev_has_upper_dev(upper_dev, dev, true))
> >> +		return -EBUSY;
> >> +
> >> +	if (__netdev_find_upper(dev, upper_dev))
> >> +		return -EEXIST;
> >
> >__netdev_has_upper_dev() can go all the way up finding the device and
> >the __netdev_find_upper() just check the first level.
> 
> 
> I do not think this ordering is somewhat inportant.

it's not the order, see below:

> >I think it would be better to use:
> >__netdev_find_upper_dev(,,deep=true/false)
> >__netdev_has_upper(,)

It's their names.  Currently, the function ..._find_... look at
one level only, while the function ..._has_... does one or more
levels.  I think it's better to swap 'has' and 'find' in their names:

__netdev_find_upper_dev(,,deep=true/false) <-- find in all levels
__netdev_has_upper(,)  <-- check only the one level.

fbl
