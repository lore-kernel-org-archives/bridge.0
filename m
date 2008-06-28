Date: Sat, 28 Jun 2008 11:31:54 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080628113154.67930358@extreme>
In-Reply-To: <48662985.39f.51db.729627875@webmaildh1.aruba.it>
References: <48662985.39f.51db.729627875@webmaildh1.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@linuxfoundation.org

On Sat, 28 Jun 2008 14:07:33 +0200
"Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net> wrote:

> 
> > Hi,
> > 
> > I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
> > tagged packets larger than 1470 bytes are not forwarded at
> > all by a bridge.
> > I think there is a bad interaction between bridge and
> > netfilter codes. Any chance to a have a patch to solve
> > this problem that limit the possibility to use the Linux
> > bridges in a environment with VLANs?
> 
> With the following command it works:
> 
> echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
> 
> but this disable the iptables support that it's important
> for obtaining complex bridge-firewall scenarios.
> 
> Regards
> Fulvio Ricciardi

Your iptables need to know about VLAN's as well.
I bet your default action is to DROP.
