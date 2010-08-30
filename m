Date: Mon, 30 Aug 2010 09:20:13 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100830092013.5ee4142c@nehalam>
In-Reply-To: <AANLkTi=h888Pn9qtK7SuF-xbEY3KDynMjKXm38wEEbiw@mail.gmail.com>
References: <AANLkTi=h888Pn9qtK7SuF-xbEY3KDynMjKXm38wEEbiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] help needed regarding crash while adding interface to
 a bridge using brctl utility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: debasis das <fordebasis@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 30 Aug 2010 16:29:43 +0530
debasis das <fordebasis@gmail.com> wrote:

> Hi,
>     I am getting a crash while adding an interface to a bridge using the
> "brctl" utility.
>     The crash dump is as below:
> 
> #vconfig add eth0 5
> #brctl addbr br0
> #brctl addif br0 eth0.5
> Oops: sig: 11 [#1]
> 
> a00: 908240ed d47c9bd0 ffffffa1 d47c9bf0 000000c0 d4a5db40 00000003 0000000c
> a08: 00000000 d47c9db0 d4b36000 000089a2 3fff0d58 d47c9e40 0000000e 3fff0f64
> pc: d082d300, ps: 00060f10, depc: 00000018, excvaddr: 00000000
> lbeg: d082fc4c, lend: d082fc57 lcount: 00000000, sar: 00000014
> 
> Stack: 00060600 03938702 d063c73c d0638c78 90824a19 d47c9c40 fffffff4
> d4649000
>        00000001 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
>        00000000 00000000 00000000 d078a510 00000000 fffffffe 00060d00
> d4a5da80
> Call Trace:
>  [<d082460e>] br_add_if+0xfa/0x23c
>  [<d0824a19>] add_del_if+0x31/0x5c
>  [<d0824f52>] br_dev_ioctl+0x50e/0x514
>  [<d0780eac>] dev_ifsioc+0x31c/0x330
>  [<d0781902>] dev_ioctl+0x616/0x6b4
>  [<d0774676>] sock_ioctl+0x1b6/0x1c0
>  [<d065aa64>] vfs_ioctl+0x14/0x3c
>  [<d065b284>] do_vfs_ioctl+0x4a4/0x4c4
>  [<d065b2c4>] sys_ioctl+0x20/0x34
>  [<d0612470>] system_call+0x40/0x50
>  [<d0611b65>] _user_exception+0x10f/0x130
> 
> Please do let me know whether this is a known issue and whether there is any
> official patch available for the same.
> Thanking in advance.

I do not see this on x86 with current kernel. It might depend on the device
used for eth0.  When interface is added to bridge, the bridge code queries
the device (via ethtool) to get the speed. It could be a bug in either
the vlan device driver or the underlying driver that is causing the
problem.
-- 
