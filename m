Date: Fri, 7 Jul 2006 11:49:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060707114918.26b099ba@dxpl.pdx.osdl.net>
In-Reply-To: <449AA3EF.9080300@kingsley.co.za>
References: <449AA3EF.9080300@kingsley.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Network seperation and ethernet bridge...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Etienne Pretorius <etiennep@kingsley.co.za>
Cc: bridge@lists.osdl.org

On Thu, 22 Jun 2006 16:06:39 +0200
Etienne Pretorius <etiennep@kingsley.co.za> wrote:

> Hello all,
> 
> I would like to know if it is possible to have 2 bridge instances 
> running - one for the internal network and the other for the external 
> network.

Yes, you can have two separate bridge instances in the system.

> What I need to explain is that I need the internal bridge to go though 
> the Linux Kernel and pass its packets to the external network bridge.
> I am also hopeful that the internal network bridge will not need an IP 
> address as I am hoping to allocate the internal network clients a gateway
> address beyond the external network bridge and so when I have 2 similar 
> machines running with both internal and external network bridges
> that when one machine dies completely then the other will take over. 
> Sooooo what I need to know is will I require proxy-arp and/or ip_forwarding?
> 
> 
> [internal NW] ---> [internal bridge port 1 of  2]----[external bridge 
> port 4 of 4] --->[GW router]----> www.google.com

No, you can't bridge a bridge.
This is done to prevent creating loops and causing deep stack nesting.

> I would like to make it so that no request can obviously enter the 
> internal network via the external bridge without having been requested 
> from the
> internal network --- something similar to tcp state marking but for all 
> protocals and/or ether types.
> 


-- 
Stephen Hemminger <shemminger@osdl.org>
Quis custodiet ipsos custodes?
