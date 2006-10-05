Message-ID: <4524CAE8.7020909@cambridgebroadband.com>
Date: Thu, 05 Oct 2006 10:05:44 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>	
	<4524BFD5.4080203@cambridgebroadband.com>
	<4c9f8dc30610050139s57c4ee9wdddf90bd2485a881@mail.gmail.com>
In-Reply-To: <4c9f8dc30610050139s57c4ee9wdddf90bd2485a881@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@gmail.com>
Cc: bridge@lists.osdl.org

You can't always believe ifconfig - it's really down to the driver.
However, if you see packets that contain source MAC addresses other
than those of eth1 or eth0, coming out of both bridge interfaces, then
they must be in promisc mode.

It might be useful to run tcpdump/ethereal on the bridge, br0, itself to
check whether it is seeing packets sent by the laptop, and if so, if it
is seeing reply packets from the router.

Another useful tool is "brctl showmacs br0"

Alex

Chris U wrote:
> Hi Alex,
> 
> In the case you mentioned previously, does ifconfig show the interface 
> in promisc mode? I have tried further investigating whether or not the 
> interface is in promisc mode by using ethtool, a soft tool, however 
> unsuccessful. I also attempted to use a hub on eth0 to see if tcpdump 
> would pick up the packets in promisc mode; the packets are successfully 
> captured on the hub. [I did not test eth1, but I shall tomorrow 
> morning.] Both network interfaces are the same model/brand. Listed below 
> is a snapshot of my ifconfig and a snippet from my lspci.
> 
> This list is pretty responsive - I just wanted to say thanks to everyone 
> for taking time to help me out. ;)
> 

