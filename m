Message-ID: <4062D6E8.6070804@tuxdriver.com>
Date: Thu, 25 Mar 2004 07:56:08 -0500
From: "John W. Linville" <linville@tuxdriver.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridging vlans...
References: <000301c41213$f4a6d7b0$f80210ac@djc.state.id.us>
In-Reply-To: <000301c41213$f4a6d7b0$f80210ac@djc.state.id.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeremy Jones <jjones@djc.state.id.us>
Cc: bridge@lists.osdl.org

Jeremy Jones wrote:

> question is this:  should the vlan interfaces on the linux firewall be
> created first, then bridged; or should the bridge interface be created, then
> vlans bound to that?
> 
> Here's the first:
> 
> ip link set eth0 up
> ip link set eth1 up
> vconfig set_bind_mode PER_DEVICE
> vconfig set_name_type DEV_PLUS_VID_NO_PAD
> vconfig add eth0 4
> vconfig add eth1 4
> vconfig add eth0 51
> vconfig add eth1 51

<snip>

> And the second:
> 
> ip link set eth0 up
> ip link set eth1 up
> brctl addbr br0 
> brctl addif br0 eth0
> brctl addif br0 eth1

<snip>

> I lean towards the first, as it gives me more interfaces to filter, and thus

Jeremy,

I have no specific experience with a situation like yours.  But, that 
won't stop me from rendering an opinion... :-)

I, too, would lean toward the first at least partly for the reason you 
describe.  But, you should also consider untagged frames and frames with 
other VLAN IDs.  The second configuration should bridge all frames 
(tagged or untagged), while the first will only be bridging frames with 
VLAN IDs of 4 or 51.  I'm not sure which is your desired behaviour, but 
I suspect it is the first configuration which you should prefer.

Hth...

John
-- 
John W. Linville
linville@tuxdriver.com

