Date: Mon, 12 Jan 2009 09:36:36 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090112093636.18525a7a@extreme>
In-Reply-To: <531916880.118131231776345415.JavaMail.root@ken>
References: <531916880.118131231776345415.JavaMail.root@ken>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Prevent MAC address from changing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Detheridge <simon@widgit.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 12 Jan 2009 16:05:45 +0000 (GMT)
Simon Detheridge <simon@widgit.com> wrote:

> Hello,
> 
> I have a box with a bridge, br0, that exists to bridge a bunch of tap interfaces together. I'm running a program that binds to this address to serve things. Unfortunately, this server (it's isc-dhcp3) doesn't like it when the mac address changes.
> 
> I've tried configuring a dummy interface dummy0, and adding it as the first interface on br0, before I bind my server to it. I was hoping that the mac address of dummy0 would be used as the mac address for br0.
> 
> What actually happens is that it uses the dummy0 mac address until the first tap interface is connected, and then the mac address changes to that of the tap interface, and my dhcp server stops working.
> 
> Is there a way I can prevent this from happening?
> 
> Thanks,
> Simon
> 

latest kernels have a way to set mac address. After setting mac address of bridge device,
then address won't change.  
