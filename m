Date: Wed, 21 Sep 2005 09:47:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050921094713.6e2046d3@localhost.localdomain>
In-Reply-To: <1127307186.15678.63.camel@quant>
References: <1127239659.12488.26.camel@quant>
	<20050921.001427.27575173.davem@davemloft.net>
	<1127307186.15678.63.camel@quant>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] TSO fix in br_dev_queue_push_xmit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Vlad Drukker <vlad@storewiz.com>
Cc: bridge@osdl.org, "; David S. Miller" <davem@davemloft.net>, ";
	Henrik Nordstrom" <hno@marasystems.com>

On Wed, 21 Sep 2005 15:53:06 +0300
Vlad Drukker <vlad@storewiz.com> wrote:

> Hi,
> 
> I see you all agree to apply :)
> 
> Stephen, repost of this patch to proper places below.
> 
> Thank you Henrik for clarification of bridge standard.
> However, silent drop of locally generated packets on 99% idle carrier
> grade machine looks like a hardware problem.
> 
> David, don't you think that having software packet drop counters is a
> bad idea? I thought, software drop counters are there to help identify
> hardware problems or lack of resources. In this case, tcp stack produced
> output that just gone. TSO is there over years and no one even noticed
> given TSO/bridge conflict mainly because there is no stats. (IMHO)
> Let's blame standards, right? 
> 

Patch is fine.

Putting in a counter would be good, but there is no good
structure to put it in.  The bridge device (br0) counters
make sense for locally generated packets, the network devices
(ethX) forwarding packets are under control of the other device
driver.

There is a whole bridge MIB defined in the standard, but adding
it would be a lot of work, and not sure if anyone would care.
