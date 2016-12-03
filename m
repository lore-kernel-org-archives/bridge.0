Return-Path: <blp@ovn.org>
Date: Sat, 3 Dec 2016 15:27:30 -0800
From: Ben Pfaff <blp@ovn.org>
Message-ID: <20161203232730.GT3129@ovn.org>
References: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
Subject: Re: [Bridge] [ovs-dev] [PATCH net-next] net: remove abuse of VLAN
	DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: "open list:OPENVSWITCH" <dev@openvswitch.org>, netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>

On Sat, Dec 03, 2016 at 10:22:28AM +0100, Michał Mirosław wrote:
> This All-in-one patch removes abuse of VLAN CFI bit, so it can be passed
> intact through linux networking stack.
> 
> Signed-off-by: Michał Mirosław <michal.miroslaw@atendesoftware.pl>
> ---
> 
> Dear NetDevs
> 
> I guess this needs to be split to the prep..convert[]..finish sequence,
> but if you like it as is, then it's ready.
> 
> The biggest question is if the modified interface and vlan_present
> is the way to go. This can be changed to use vlan_proto != 0 instead
> of an extra flag bit.
> 
> As I can't test most of the driver changes, please look at them carefully.
> OVS and bridge eyes are especially welcome.

This appears to change the established Open vSwitch userspace API.  You
can see that simply from the way that it changes the documentation for
the userspace API.  If I'm right about that, then this change will break
all userspace programs that use the Open vSwitch kernel module,
including Open vSwitch itself.
