Return-Path: <stephen@networkplumber.org>
Date: Wed, 14 May 2014 08:42:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20140514084251.317ed026@nehalam.linuxnetplumber.net>
In-Reply-To: <1400080168-16625-3-git-send-email-vyasevic@redhat.com>
References: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
	<1400080168-16625-3-git-send-email-vyasevic@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/8] bridge: Keep track of ports
 capable of automatic discovery.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jhs@mojatatu.com, john.r.fastabend@intel.com, shemminger@vyatta.com

On Wed, 14 May 2014 11:09:22 -0400
Vlad Yasevich <vyasevic@redhat.com> wrote:

> @@ -58,6 +61,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
>  
>  	if (flags != p->flags) {
>  		p->flags = flags;
> +		br_port_flags_change(p, old_flags ^ flags);

You are also xoring twice.

Why not:

store_flag()
	if (flags != p->flags) {
		br_port_flags_change(p, flags);
		p->flags = flags;
		br_ifinfo_notify(RTM_NEWLINK, p);
