Date: Fri, 17 Nov 2006 13:18:35 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061117131835.700c6d58@freekitty>
In-Reply-To: <455E1E72.5090503@asgardsrealm.net>
References: <455E1E72.5090503@asgardsrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Can the bridge MAC be controlled/changed?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Jamin W. Collins" <jcollins@asgardsrealm.net>
Cc: bridge@lists.osdl.org

On Fri, 17 Nov 2006 15:41:22 -0500
"Jamin W. Collins" <jcollins@asgardsrealm.net> wrote:

> I'm attempting to use a ethernet bridge to solve the following problem:
> 
> VM Ware's player allows a guest operating system to be bridged in with 
> an existing network interface on the host operating system.  My problem 
> is that the connected interface on my host system varies between my 
> wired and wireless ports depending on my location.  So, I decided to try 
> creating a bridge (br0) between the two interfaces (eth0 and eth1) and 
> then configuring VM Ware to bridge to br0 instead of either eth0 or eth1.
>
> This appears to work as expected with one caveat. When both interfaces 
> are members of the bridge and the wired port is not connected, the 
> bridge can not acquire and IP.  However, when the wired port is removed 
> from the bridge it can acquire an IP.
> 
> Attempting to investigate this, I found that regardless of the order in 
> which the interfaces are added to the bridge, the bridge always winds up 
> with the MAC address of the wired port when both are members of the 
> bridge.  If the wired port is removed (or not yet added) the MAC of the 
> bridge is that of the wireless port.
>

The bridge MAC address always defaults to the smallest value because
that is part of the 802.11 specification. When doing spanning tree,
the protocol needs to have consistent rules when determining paths.

In later 2.6 kernels, you can reset the hardware address to be the
same as any of the interfaces being bridged. But when ever an interface
is added or deleted, the minimum value is used. 

See the FAQ on http://linux-net.osdl.org/index.php/Bridge

> So, it appears that as long as the bridge has the same MAC as the 
> wireless it can acquire an IP over the wireless interface.
> 
> Is there a way to control the MAC address that gets assigned to the 
> bridge interface?  Or is there a better way to accomplish my goal of 
> being able to switch between wired and wireless ports while bridging in 
> a VM guest?

Bridging wireless is another set of problems, to bridge wireless properly
the bridge would have to support 802.11c and only some hardware will work
for that. 

-- 
Stephen Hemminger <shemminger@osdl.org>
