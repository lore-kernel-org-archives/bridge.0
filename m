Date: Fri, 27 Aug 2004 09:31:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Getting dynamic ip address for a bridge
Message-Id: <20040827093146.4f167f3b@dell_ss3.pdx.osdl.net>
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A5476101554381@mailguy2.nuvation.com>
References: <FC3C0DD86B79DF4FA423AF0379A5476101554381@mailguy2.nuvation.com>
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
To: Oliver King-Smith <oliver.king-smith@nuvation.com>
Cc: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

On Fri, 27 Aug 2004 08:54:22 -0700
Oliver King-Smith <oliver.king-smith@nuvation.com> wrote:

> Hello,
> 
> I how an embedded processor that needs to act as a bridge between a wireless
> and wired network.  I have managed to bring up the bridge fine.  I can also
> bring up the bridge with a static ip address.  However I can not figure out
> how to bring up the bridge with a dynamic ip address.
> 
> Is it possible to for a bridge to get a dynamically assigned ip address?
> 
> Oliver

DHCP will work on the bridge interface (br0) but you need to have the
bridge and ethernets up, and the forwarding delay has to expired.
After that the eth0 will be in the forwarding state.
