Date: Mon, 9 May 2005 10:50:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Port link status disconnect
Message-ID: <20050509105035.5f1c945f@dxpl.pdx.osdl.net>
In-Reply-To: <6.1.2.0.2.20050509184627.05a787d0@luna.tlmat.unican.es>
References: <427D8B20.7010301@SiuLung.com>
	<6.1.2.0.2.20050509184627.05a787d0@luna.tlmat.unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jorge Lanza <jlanza@tlmat.unican.es>
Cc: bridge@lists.osdl.org

On Mon, 09 May 2005 18:59:54 +0200
Jorge Lanza <jlanza@tlmat.unican.es> wrote:

> Hi all.
> 
> I have been working with bridges on kernel 2.4.X but now I have upgrade to 
> kernel 2.6.11 and the behaviour seems to be different.
> I face problem when I include a wireless device as in /var/log/messages I 
> get (3-5) which before I didn't.
> 
> 1)May  5 10:53:01 fuj1 kernel: br0: topology change detected, propagating
> 2)May  5 10:53:01 fuj1 kernel: br0: port 2(eth2) entering forwarding state
> 3)May  5 10:53:06 fuj1 kernel: eth2: New link status: Disconnected (0002)
> 4)May  5 10:53:06 fuj1 kernel: ip_tables: (C) 2000-2002 Netfilter core team
> 5)May  5 10:53:07 fuj1 kernel: eth2: New link status: Connected (0001)
> 6)May  5 10:53:20 fuj1 kernel: br0: port 2(eth2) entering disabled state
> 
> 
> Lets explain the steps I follow. Brigde ports  --- eth1 wired 
> interface      eth2 wireless interface
> To set up the bridge and include both ports I run the following.
> 
> brctl addbr br0
> brctl addif br0 eth1
> brctl addif br0 eth2
> ifconfig eth1 0.0.0.0
> ifconfig eth2 0.0.0.0
> ifconfig br0 10.0.1.4 up
> 
> As you can see I set the eth2 ip address to 0.0.0.0. However after a while 
> the eth2 returns by it self to the previous configured IP address (i.e. 
> 128.0.1.50). So, in order to make things work in the correct way I have to 
> retype ifconfig eth2 0.0.0.0 and the second time seems that everything 
> works as expected and the eth2 doesn't go back to the previous state.
> 
> Why does it happen? What can I do? I need the device not to "get out of the 
> brigde" and reconfigured. I have try to brctl br0 setfd 0  but still have 
> the same problem.
>

Probably you have eth2 configured in the normal distribution network configuration
and the hotplug scripts are detecting the transition and setting it back.

You need to make sure eth interfaces are not configured by other means.
