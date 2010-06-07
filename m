Date: Mon, 7 Jun 2010 13:00:15 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100607130015.15555744@nehalam>
In-Reply-To: <1275940248.26597.70.camel@calx>
References: <24059.1275417767@death.nxdomain.ibm.com>
	<1275938692-26997-1-git-send-email-fleitner@redhat.com>
	<1275940248.26597.70.camel@calx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netconsole: queue console messages to send
	later
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Matt Mackall <mpm@selenic.com>
Cc: bridge@lists.linux-foundation.org, Flavio Leitner <fleitner@redhat.com>, bonding-devel@lists.sourceforge.net, Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Jay Vosburgh <fubar@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>, David, Flavio Leitner <fbl@sysclose.org>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, Miller <davem@davemloft.net>

On Mon, 07 Jun 2010 14:50:48 -0500
Matt Mackall <mpm@selenic.com> wrote:

> On Mon, 2010-06-07 at 16:24 -0300, Flavio Leitner wrote:
> > There are some networking drivers that hold a lock in the
> > transmit path. Therefore, if a console message is printed
> > after that, netconsole will push it through the transmit path,
> > resulting in a deadlock.
> 
> This is an ongoing pain we've known about since before introducing the
> netpoll code to the tree.
> 
> My take has always been that any form of queueing is contrary to the
> goal of netpoll: timely delivery of messages even during machine-killing
> situations like oopses. There may never be a second chance to deliver
> the message as the machine may be locked solid. And there may be no
> other way to get the message out of the box in such situations. Adding
> queueing is a throwing-the-baby-out-with-the-bathwater fix.
> 
> I think Dave agrees with me here, and I believe he's said in the past
> that drivers trying to print messages in such contexts should be
> considered buggy.
> 

Because it to hard to fix all possible device configurations.
There should be any way to detect recursion and just drop the message to
avoid deadlock.

-- 
