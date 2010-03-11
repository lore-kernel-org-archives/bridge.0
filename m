Date: Wed, 10 Mar 2010 22:34:11 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100310223411.337b702d@nehalam>
In-Reply-To: <20100311045123.GB3123@aquila.north.oberlin.edu>
References: <20100311045123.GB3123@aquila.north.oberlin.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Disabling MAC address tracking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nathaniel Gephart <10thaperag@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 10 Mar 2010 23:51:23 -0500
Nathaniel Gephart <10thaperag@gmail.com> wrote:

> Hello,
> 
> I'm using bridge-utils as part of a Xen installation. I've got a bunch of
> isolated bridges connecting up a number of virtual machines. I would like these
> bridges to act more like hubs. That is, instead of keeping track of which MAC
> addresses are on which ports, I want them to forward frames to all ports always.
> Is there a way to do this?
> 
> Thanks,
> 
> Nate Gephart
> 

Just set hold time to zero.

-- 
