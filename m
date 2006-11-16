Date: Wed, 15 Nov 2006 21:37:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061115213740.17f8253f@localhost.localdomain>
In-Reply-To: <455BBBD2.4060705@lisco.com>
References: <455BBBD2.4060705@lisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge works, but how host is limited
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: tmiller@lisco.com
Cc: bridge@osdl.org

On Wed, 15 Nov 2006 19:16:02 -0600
Tom Miller <tmiller@lisco.com> wrote:

> I've got a bridge up on my Suse 10 box, let's call it the bridge host.
> The 2 NICs are connected, and my main box (Suse 10.1) can print to the
> printer on the other side of the bridge host. Everything pings
> everywhere, i.e. the LAN extends across the bridge as expected. Cool!
> 
> I used the basic configuration:
> 
>    1. ifconfig eth0 0.0.0.0
>    2. ifconfig eth1 0.0.0.0
>    3. brctl addbr mybridge
>    4. brctl addif mybridge eth0
>    5. brctl addif mybridge eth1
> 
> plus:
> 
>     ifconfig mybridge 192.168.100.5 netmask 255.255.255.0
> 
> On the bridge host, I can browse to an Apache-served web page on my main
> box, but cannot browse to the Internet or print on the printer. Wonder
> what is wrong? Any suggestions?
> 
> Is there some way to configure the bridge itself as a network device?
> 
> Thanks
> Tom
> 

You have no default route. You created a static IP entry, but there is no
route to your gateway.  If you use DHCP, then it sets up default route
as well.
