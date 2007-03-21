Date: Wed, 21 Mar 2007 10:38:56 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070321103856.272a0b5c@dxpl.pdx.osdl.net>
In-Reply-To: <200703211928494846240@4ever-light.com>
References: <200703211928494846240@4ever-light.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] why ./brctl showmacs br0 display nothing?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alex <alex@4ever-light.com>
Cc: bridge <bridge@lists.linux-foundation.org>

On Wed, 21 Mar 2007 19:28:50 +0800
"Alex" <alex@4ever-light.com> wrote:

> 
> hi:
> my box use eth0 connect my pc. but I type command "./brctl showmacs br0", no mac addr display and the" brctl showmacs program" not exit,always exec
> 
> # ./brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000123456789       no              eth0
>                                                         hdlc0
> # ./brctl showmacs br0
> port no mac addr                is local?       ageing timer

What kernel version?

Showmacs tries to get the information by reading /sys/class/br0/brforward
Does your system not support sysfs?  Does that file exist?

For older 2.4 system it uses an ioctl.
