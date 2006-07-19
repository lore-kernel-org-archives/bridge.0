Date: Wed, 19 Jul 2006 15:19:44 -0400
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060719151944.6a238a7c@localhost.localdomain>
In-Reply-To: <6.2.1.2.0.20060719172004.031b75f0@172.16.1.10>
References: <6.2.1.2.0.20060719172004.031b75f0@172.16.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] D-Link cards unable to receive multicast traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: mahesh kumar <kmkumar@intoto.com>
Cc: bridge@osdl.org

On Wed, 19 Jul 2006 17:41:01 +0530
mahesh kumar <kmkumar@intoto.com> wrote:

> 
> Hi,
> 
>    I got problem while receiving multicast traffic on to my  D-Link 
> DFE-520TX PCI Fast Ethernet Adapter.
> 
>    Created bridge interface and attached the eth0 interface (D-link) to the 
> bridge.
> 
>    H1------------------------eth0[LX-Bridge]
> 
>    Started Multicast traffic from H1 to Bridges eth0 port and the "tcpdump" 
> doesn't who any packets
> 
>    If the eth0 interface is detached from brdge its receiving the multicast 
> packets

What driver is the ethernet using?
Which kernel version?
