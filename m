Date: Mon, 23 Aug 2004 10:31:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Encrypting Bridge?
Message-Id: <20040823103126.72631cf6@dell_ss3.pdx.osdl.net>
In-Reply-To: <3739.80.133.187.52.1092948476.squirrel@80.133.187.52>
References: <3739.80.133.187.52.1092948476.squirrel@80.133.187.52>
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
To: Rene Bartsch <ML@Bartschnet.de>
Cc: bridge@lists.osdl.org

On Thu, 19 Aug 2004 22:47:56 +0200 (CEST)
"Rene Bartsch" <ML@Bartschnet.de> wrote:

> Hi,
> 
> I've read the description of encrypting bridge on
> http://www.arnor.net/encryptingbridge. But this is for kernel 2.4.19 and
> very old. Is there any encrypting code in the current linux-2.6 code or a
> patch?
> 
> What I need is a solution to connect to bridges transparently by a
> encrypted tunnel and I don't want to add lots of user-space proggies on
> the routers or dependencies to network protocols (which means I want to
> connect two networks on the bridge layer by a encryted IPv4 tunnel running
> through the internet, but be able to transmit any kind of network protocol
> through the tunnel).
> 
> Thanx for any help
> 
> Rene

OpenVPN uses tun/tap so it should be possible to create a tunnel
device on both ends and add it to the bridge.

The encrypting bridge isn't a bad idea, just not sure it is worth maintaining
yet another VPN solution.
