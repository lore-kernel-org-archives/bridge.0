Date: Thu, 24 Feb 2005 14:30:37 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050224143037.211e6d56@dxpl.pdx.osdl.net>
In-Reply-To: <421E54A3.3020806@abwaters.com>
References: <421E54A3.3020806@abwaters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Stephen
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bryan Waters <bryanw@abwaters.com>, bridge@osdl.org

On Thu, 24 Feb 2005 15:26:43 -0700
Bryan Waters <bryanw@abwaters.com> wrote:

> I'm trying to debug my bridge...i've sent an email to the list but i'm 
> not yet approved by the moderator.  Can you help me?
> 
> thx
> -bryanw
> 
> ---------------------------------- Email to Bridge Mailing List 
> -----------------------------------------
> I've got a 2.6.8 kernel with bridging enabled as a module, two nics 
> (LNE100TX and RTL8139) and i've run the following commands with no errors
> 
> modprobe -v bridge
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> 
> both interfaces have 0.0.0.0 as their addresses and brctl showmacs br0 
> shows the macs for both internal cards.  However, bridging doesn't seem 
> to be working at all.  What am I missing or what else can I try to debug 
> what might be wrong?

Are the eth0, eth1 marked as up?  also it takes a while for the spanning
tree timers to go from learning to forwarding state.  Look at brctl show stp br0
