Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nzo/EeesMtT8+pXjBytb6EDMDl5fNWcRIsQYNOA5AM4=;
 b=ukIYTF+gazi+wlQK1oKO3hBUJnAA2/GAnOMr6rjauImDVUtVs13TmnqFcszfwIvxum
 2H9UJNP6bxlGVp2lAtCIudbc9GHBttcOC/fHI0O/DL1U58YEJz9Tv7zVqTMSnF8DeMhI
 rGlPPS193fEvweoLv+REyq8b3Akk53RKqnu7yPGi5m1iK5eTQQoE9rxONF8w8wIX5WFU
 izrafqIikmK1GSrThwopKSqB3JLifbuas2h+FShsn6ZLhl8oXxvWNb08JUBje7CF+e9H
 KUeHOm0Ts7tPCDvYmaWE7epq0F4dj2HkawR6uE0bNMRsEzvzoo+UVbKtif/UMrUEspzD
 B4WQ==
Date: Thu, 23 Jan 2020 08:25:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200123082542.06ed0a53@hermes.lan>
In-Reply-To: <20200123132807.613-2-nikolay@cumulusnetworks.com>
References: <20200123132807.613-1-nikolay@cumulusnetworks.com>
 <20200123132807.613-2-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: check port state
 before br_allowed_egress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Thu, 23 Jan 2020 15:28:04 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		br_allowed_egress(vg, skb) && p->state == BR_STATE_FORWARDING &&
> +		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }

Maybe break this complex return for readability?
