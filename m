Date: Wed, 18 Jul 2007 14:27:29 +0100
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Reading and writing from tap device attacted to bridge
Message-ID: <20070718142729.10adca3e@oldman>
In-Reply-To: <228b46650707180607v2d8e8abar99bb0e3af8548ab3@mail.gmail.com>
References: <228b46650707180607v2d8e8abar99bb0e3af8548ab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rajneesh rana <rana.rajneesh@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 18 Jul 2007 18:37:38 +0530
"rajneesh rana" <rana.rajneesh@gmail.com> wrote:

> On 7/18/07, rajneesh rana <rana.rajneesh@gmail.com> wrote:
> >
> > I'm trying to trap ethernet frames from a user process over the wire,
> > using the linux tap device. I see a lot of docs/threads about using tun
> > device, but none for tap device.

Use AF_PACKET, it is easier and faster. That is what tcpdump etc use.

> > I am able to open Tap device and attach it to bridge but getting no clue
> > how to read and write  data from tap device.

Examples in http://vtun.sourceforge.net/tun/
