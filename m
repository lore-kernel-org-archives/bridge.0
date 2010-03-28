Date: Sat, 27 Mar 2010 20:00:36 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100327200036.7e4cc31d@nehalam>
In-Reply-To: <7515418c.2b6d6e39.4ba7656f.e09eb@o2.pl>
References: <7515418c.2b6d6e39.4ba7656f.e09eb@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge and port forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Olek <ned_wed@o2.pl>
Cc: bridge@lists.linux-foundation.org

On Mon, 22 Mar 2010 13:41:19 +0100
Olek <ned_wed@o2.pl> wrote:

> Hi,
> I'm stuck with the configuration of my server.
> Currently my network is set up like this:
> 
> 
> Internet 
>   |
>   |
> Router
> (WAN 192.168.0.99, LAN 192.168.1.99, 
> port forwarding 1-65535)
>   |
>   |
> Ubuntu Server 64-bit
> (WAN(eth0) 192.168.1.110, LAN-bridge(eth1,eth2) 192.168.0.110)
> 
> 
> Description of the problem:
> When I connect my desktop to the router LAN and try to access FTP, SSH or others the server answers correct (brigde enabled).
> When I try to access the server from the Internet, i get no answer.
> When the bridge is disabled I can easily access SSH or FTP from the Internet.
> 
> My bridge config:
> ifconfig eth1 promisc up
> ifconfig eth2 promisc up

Unnecessary step. Bridge has done this automatically for at least
5 years, probably more. But old instructions never die.

> brctl addbr mybridge
> brctl addif mybridge eth1
> brctl addif mybridge eth2
> 
> The firewall is disabled, to get sure it's not blocking network traffic.
> Maybe someone knows what's causing this problem?

You need to assign IP address to br0, not the ethernets in the bridge?
