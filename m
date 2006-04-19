Date: Wed, 19 Apr 2006 09:29:29 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] large packet size doesn't work
Message-ID: <20060419092929.381eec86@localhost.localdomain>
In-Reply-To: <20060419073424.9133.qmail@webmaild.fe1.aruba.it>
References: <20060419073424.9133.qmail@webmaild.fe1.aruba.it>
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
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@lists.osdl.org

On Wed, 19 Apr 2006 09:34:23 +0200
"Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net> wrote:

> Hi,
> I have just configured a Linux box with kernel 2.6.16.7 and configured two 
> ethernet interfaces (with MTU 1500) in bridge mode. CONFIG_BRIDGE_NETFILTER 
> is enabled.
> The problem is that ping -s 1500 192.168.0.2 doesn't work from 192.168.0.1 
> if the systems are separated by the bridge. Normal ping with smaller packet 
> size works ok.
> What is wrong? 
> 
> Best Regards
>  Fulvio Ricciardi
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

Are you using VLAN's ? The bridge will not send packets to a device if
packet size > mtu of device.  VLAN's confuse it.
