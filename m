Date: Mon, 6 Oct 2003 02:11:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Message-ID: <20031006051132.GD12912@conectiva.com.br>
References: <20030927202200.GA612@man.beta.es>
	<p05111b00bba2061773df@[10.96.96.13]>
	<20031002160041.47053537.shemminger@osdl.org>
	<20031004155435.GB1174@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004155435.GB1174@man.beta.es>
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-net@vger.kernel.org, Hannes Schulz <schulz@schwaar.com>, marcelo.tosatti@cyclades.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

Em Sat, Oct 04, 2003 at 05:54:35PM +0200, Santiago Garcia Mantinan escreveu:
> The problem went away when I replaced the bridge code in 2.4.22 with the one
> from 2.4.23-test6, so, after seing that this fixed the problem I did a diff
> and found that the only diffs were just two lines:
> 
> diff -ru bridge.2422/br_forward.c bridge/br_forward.c
> --- bridge.2422/br_forward.c	2002-08-03 02:39:46.000000000 +0200
> +++ bridge/br_forward.c	2003-10-03 19:46:35.000000000 +0200
> @@ -59,6 +59,7 @@
>  
>  	indev = skb->dev;
>  	skb->dev = to->dev;
> +	skb->ip_summed = CHECKSUM_NONE;
>  
>  	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
>  			__br_forward_finish);
> diff -ru bridge.2422/br_stp_bpdu.c bridge/br_stp_bpdu.c
> --- bridge.2422/br_stp_bpdu.c	2003-08-25 13:44:44.000000000 +0200
> +++ bridge/br_stp_bpdu.c	2003-10-03 19:46:35.000000000 +0200
> @@ -194,6 +194,6 @@
>  	}
>  
>   err:
> -	kfree(skb);
> +	kfree_skb(skb);
>  	return 0;
>  }
> 
> So, now I'm asking myself, how can this bug that is fixed by these two lines
> in the bridge code, be affecting my loopback?
> 
> Anybody can explain this, please?
> 
> Thanks in advance and thanks for all your help as well.

Well, kfree_skb doesn't frees the sk_buff right away, it looks at its refcnt,
while kfree just puts the area in the pointer in the pool, back to be reused,
so what has happened most probably is that when the skb, that was being shared,
but is now freed by kfree hits the packet sniffer... b00m, or it is being used
for something else or is outright damaged, or both.

I.e. it should be freed after the packet sniffer is done with it, and most
importantly, with the proper destructor, kfree_skb.

- Arnaldo
