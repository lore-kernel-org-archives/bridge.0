Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IL5okzt2H7dQ4aWWrCY8FlzqAqMfen+mIGwM4lATuF0=;
	b=yZ1DvCXQvxqXKzR2f9ssgtKFTXp+ZH71zs6kGWCIIimD7KPQH8RfJSt5O5h2EVf6Dw
	k1y5QBJPndKd3OABA654zPcfXnM7yciCd4uVZgQahUHotFgyL6TYnWv+mEoU0S5o/FqY
	sBpnY2mwqzSg9C4exNn+qHAQuZX6eXOsEzk8Q7suvDUW5oUQdN4vjXyeNzxM8HBdt6Ke
	oQXJ6SYZJHlOwNdFO1gT3Vb2esbAVIsdKfZK63avNeDtQRScA9T2NogmyzLdPHCvU1yg
	HYE0xKuk/rYjcZr3GEx0DrX1QVg/xKoj8t7rCUcnm1QkkoEQML77g2PzYhDivhGWJ8Zc
	BVnQ==
Date: Tue, 3 Oct 2017 13:43:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171003134311.34681644@xeon-e3>
In-Reply-To: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
References: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Fix format string for %ul
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, 26 Aug 2016 23:10:28 -0400
Oleg Drokin <green@linuxhacker.ru> wrote:

> %ul would print an unsigned value and a letter l,
> likely it was %lu that was meant to print the long int,
> but in reality the values printed there are just regular signed
> ints, so just dropping the l altogether.
> 
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
>  net/bridge/br_stp_bpdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
> index 5881fbc..15c4a9c 100644
> --- a/net/bridge/br_stp_bpdu.c
> +++ b/net/bridge/br_stp_bpdu.c
> @@ -230,7 +230,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
>  			if (net_ratelimit())
>  				br_notice(p->br,
>  					  "port %u config from %pM"
> -					  " (message_age %ul > max_age %ul)\n",
> +					  " (message_age %u > max_age %u)\n",
>  					  p->port_no,
>  					  eth_hdr(skb)->h_source,
>  					  bpdu.message_age, bpdu.max_age);

Could you make the format string a single line plwase.
And add Fixes tag.
