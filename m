Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=1X+2YgoXTAyBlIJgma5KiZIdDCsrXZFX9JNuG5zGnuU=;
	b=KcjX22jY4dHXQKALixbTx17S0a3JWoFGkov1y6GGrTcW1/ac4PhuK12bXTuUfBLKLN
	dEBEEfrulWLxheBMEDXf04XiGbgTn+JPUDlyZEW+KwDLw/BAEnX1ZYqL5cW9Qm4PnlCu
	+rUrqty3eIF+02tuwwGrYdpExTDaRxmAkF9KM=
References: <20190222132232.24123-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f786acf3-d6f5-50b7-a39d-95558ec039a5@cumulusnetworks.com>
Date: Fri, 22 Feb 2019 18:20:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190222132232.24123-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net] Revert "bridge: do not add port to router
 list when receives query with source 0.0.0.0"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, yinxu@redhat.com, Sebastian Gottschall <s.gottschall@newmedia-net.de>, davem@davemloft.net

On 22/02/2019 15:22, Hangbin Liu wrote:
> This reverts commit 5a2de63fd1a5 ("bridge: do not add port to router list
> when receives query with source 0.0.0.0") and commit 0fe5119e267f ("net:
> bridge: remove ipv6 zero address check in mcast queries")
> 
> The reason is RFC 4541 is not a standard but suggestive. Currently we
> will elect 0.0.0.0 as Querier if there is no ip address configured on
> bridge. If we do not add the port which recives query with source
> 0.0.0.0 to router list, the IGMP reports will not be about to forward
> to Querier, IGMP data will also not be able to forward to dest.
> 
> As Nikolay suggested, revert this change first and add a boolopt api
> to disable none-zero election in future if needed.
> 
> Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Reported-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> Fixes: 0fe5119e267f ("net: bridge: remove ipv6 zero address check in mcast queries")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_multicast.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 

Thank you. Unfortunately we made a mistake and have to fix compatibility with
the current bridges. As noted in the commit message if this is needed it can
be added as optional behaviour with default off so we don't break any setups.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
