Message-ID: <46429ED2.10809@candelatech.com>
Date: Wed, 09 May 2007 21:25:54 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <2638DE26-D672-4245-BE88-D13B7F0F34A9@mac.com>
In-Reply-To: <2638DE26-D672-4245-BE88-D13B7F0F34A9@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [BUG][debian-2.6.20-1-686] bridging + vlans + "vconfig
 rem" == stuck kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: netdev@vger.kernel.org, OSDL Linux Bridging <bridge@osdl.org>, LKML Kernel <linux-kernel@vger.kernel.org>

Kyle Moffett wrote:
>
> vconfig       D 83CCD8CE     0 16564  16562                     (NOTLB)
>        efdd7e7c 00000086 ee120afb 83ccd8ce 98f00788 b7083ffa 5384b49a 
> c76c0b05
>        9ebaf791 00000004 efdd7e4e 00000007 f1468a90 2ab74174 00000362 
> 00000326
>        f1468b9c c180e420 00000001 00000286 c012933c efdd7e8c df98a000 
> c180e468
> Call Trace:
> [<c012933c>] lock_timer_base+0x15/0x2f
> [<c0129445>] __mod_timer+0x91/0x9b
> [<c02988f5>] schedule_timeout+0x70/0x8d
> [<f8b75209>] vlan_device_event+0x13/0xf8 [8021q]

Looks like a deadlock in the vlan code.  Any chance you can run this 
test with
lockdep enabled?

You could also add a printk in vlan_device_event() to check which event 
it is hanging on, and
the netdevice that is passed in.

Since the vlan code holds RTNL at this point, then most other network 
tasks will eventually
hang as well.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


