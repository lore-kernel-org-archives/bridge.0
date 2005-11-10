Date: Thu, 10 Nov 2005 10:32:34 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] 'dhcpcd' fails when run on wireless-wired bridge device
Message-ID: <20051110103234.18f1dcdc@dxpl.pdx.osdl.net>
In-Reply-To: <4372D918.3050209@bway.net>
References: <4372D918.3050209@bway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Ryan B. Lynch" <rlynch@bway.net>
Cc: bridge@lists.osdl.org

On Thu, 10 Nov 2005 05:22:32 +0000
"Ryan B. Lynch" <rlynch@bway.net> wrote:

> Hi,
> 
> I'm experiencing a DHCP client failure when running 'dhcpcd' on the
> bridge interface itself.  Here are the basics:
> 
> "eth0" is ordinary, wired ethernet
> "eth1" is a wireless 802.11b/g device (ipw2200 driver)
> 
> There is a working DHCP server on the wireless network, which has been
> tested and works when trying to run 'dhcpcd' on the wireless device
> itself.  At the beginning, everthing is "down" with no IP addresses
> assigned.  I bring up the bridge and add the devices in this order:
> 
>     > ip link set eth0 up
>     > ip link set eth1 up
>     > iwconfig eth1 essid "my_essid"
>     > iwconfig eth1 key "my_key"
> 
>     > (pause to let the wireless client associate)
> 
>     > brctl addbr br0
>     > brctl addif br0 eth0
>     > brctl addif br0 eth1
>     > ip link set br0 up

Did you wait 30 seconds for the bridge to put the port
into the forwarding state?

> 
> Now, I try to get a DHCP lease for the "br0" device, using 'dhcpcd':
> 
>     > dhcpcd -C -t 10 -d br0
>
-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
