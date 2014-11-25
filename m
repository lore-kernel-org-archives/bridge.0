Return-Path: <stephen@networkplumber.org>
Date: Tue, 25 Nov 2014 15:13:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20141125151308.3ede216c@urahara>
In-Reply-To: <CAHD0KLkXTH5fOMuxc7r6RQQ5f6J4vEOiGqjj1NsOSANq0=p0ZQ@mail.gmail.com>
References: <CAHD0KLkXTH5fOMuxc7r6RQQ5f6J4vEOiGqjj1NsOSANq0=p0ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Consuming LACP PDUs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jogesh panda <jogesh.panda@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 25 Nov 2014 10:12:02 -0800
jogesh panda <jogesh.panda@gmail.com> wrote:

> Hi
> 
> I have two virtual machine. In side each VM, there is a Switch emulation.
> Two create connection between emulated switches, I have create Tutap
> Interfaces in the host which are seen as Virtual Interfaces inside the VMs.
> The tuntap Interfaces are connected by brctl bridge.
> 
> I am having problem with the LACP PDUs, which needs to be forwarded by the
> bridge.  Stp is disabled on the bridge. Bridge is consuming the LACP PDUs
> 
> I have programmed the ebtables as following
> 
> 
> $ sudo ebtables -L
> Bridge table: filter
> 
> Bridge chain: INPUT, entries: 2, policy: ACCEPT
> -p 0x8809 -j ACCEPT
> -p 0x8809 -j ACCEPT
> 
> Bridge chain: FORWARD, entries: 2, policy: ACCEPT
> -p 0x8809 -j ACCEPT
> -p 0x8809 -j ACCEPT
> 
> Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
> -p 0x8809 -j ACCEPT
> 
> I am using Linux
>  uname -a
> Linux Nile 3.5.0-45-generic #68~precise1-Ubuntu SMP Wed Dec 4 16:18:46 UTC
> 2013 x86_64 x86_64 x86_64 GNU/Linux
> 
> Any help is much appreciated.
> 
> Thanks in advance.
> Jogesh


Link local packets are not meant to be forwarded.
There is a special forwarding mask in current version of bridge.

commit 515853ccecc6987dfb8ed809dd8bf8900286f29e
Author: stephen hemminger <shemminger@vyatta.com>
Date:   Mon Oct 3 18:14:46 2011 +0000

    bridge: allow forwarding some link local frames
    
    This is based on an earlier patch by Nick Carter with comments
    by David Lamparter but with some refinements. Thanks for their patience
    this is a confusing area with overlap of standards, user requirements,
    and compatibility with earlier releases.
    
    It adds a new sysfs attribute
       /sys/class/net/brX/bridge/group_fwd_mask
    that controls forwarding of frames with address of: 01-80-C2-00-00-0X
    The default setting has no forwarding to retain compatibility.
    
    One change from earlier releases is that forwarding of group
    addresses is not dependent on STP being enabled or disabled. This
    choice was made based on interpretation of tie 802.1 standards.
    I expect complaints will arise because of this, but better to follow
    the standard than continue acting incorrectly by default.
    
    The filtering mask is writeable, but only values that don't forward
    known control frames are allowed. It intentionally blocks attempts
    to filter control protocols. For example: writing a 8 allows
    forwarding 802.1X PAE addresses which is the most common request.
    
    Reported-by: David Lamparter <equinox@diac24.net>
    Original-patch-by: Nick Carter <ncarter100@gmail.com>
    Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
    Tested-by: Benjamin Poirier <benjamin.poirier@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
