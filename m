Date: Tue, 30 Nov 2004 11:38:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20041130113831.56950b83@zqx3.pdx.osdl.net>
In-Reply-To: <31F5998A44B92447BD334F8FBBA0B01F081412B7@orsmsx401.amr.corp.intel.com>
References: <31F5998A44B92447BD334F8FBBA0B01F081412B7@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Bridge Query...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Awasthi, Vinay K" <vinay.k.awasthi@intel.com>
Cc: bridge@osdl.org

On Tue, 30 Nov 2004 09:41:59 -0800
"Awasthi, Vinay K" <vinay.k.awasthi@intel.com> wrote:

> Stephen,
> 
> I am running a bidirectional test after adding 2 adapters to the bridge.
> I am seeing that rate at one port is higher that the other. This does
> not happen when I run uni-directional traffic on either adapter. My
> configuration is as follows.
> 

Is the bridge able to learn the addresses?  (ie brctl showmacs br0)
Also are you using ebtables as well?

What happens if you just send a few frames, what shows up on the 
network?

> 
> SMART BITS <----> ADAPTER1 <----> BRIDGE <----> ADAPTER2 <----> SMART
> BITS.
> 
>  
> 
> STP is not enabled on the bridge.
> 
>  
> 
> To run bidirectional traffic I set both smart bits to send broadcast
> packets to both adapters and see how many of these packets are received
> on each end...This error is more pronounced at jumbo frame sizes. I
> could not adjust MTU for BR0 device (this device is bridge). Now if I
> add devices in different order, I get different performance...(i.e. poor
> performance seems to follow the first adapter that was added...this does
> not happen all the time...).

MTU of bridge br0 (in 2.6 kernel) is the minimum of the devices in bridge.

> 
> Can you tell me how I can configure bridge to simply pass ALL packets
> from one interface to other without looking into headers?

Not possible. That isn't what a 802.2 bridge does.

Other than performance test, what are you really trying to accomplish.
You just gave me facts, not a description of the real goa.
