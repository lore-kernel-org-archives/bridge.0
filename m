Date: Wed, 31 Aug 2005 13:25:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050831132533.0b922bcc@dxpl.pdx.osdl.net>
In-Reply-To: <000301c5ae41$d4a493f0$6401000a@operator>
References: <000301c5ae41$d4a493f0$6401000a@operator>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Please help with bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: InterClub <intclub@voliacable.com>
Cc: bridge@osdl.org

On Wed, 31 Aug 2005 18:37:00 +0300
"InterClub" <intclub@voliacable.com> wrote:

> I need to add to bridge virtual interface with MAC address.
> How can I do so?
> 
>             
>                           +-----+
> NET 1     eth0---|  br   |---eth1    NET 2
>                           +-----+
>                                |
>                          virtuarl if
> 
> virtual if mast be visible from network with its own macaddress 
> and can be able to get IP by DHCP (dhcpcd) from any network
> 
> I need this very much.
> Sanks 

What kind of virtual interface?  The bridge code expects the devices
in the bridge to behave like linux ethernet devices.
