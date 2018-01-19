Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jURbgeTawy4pEitIxjOGsXZBrIGOITvRNhgnR15KCFw=;
	b=c9E9sAWpMIPjjxc48gezdP4vdOQY9jDG+DQCkaSUEdZDTwE3cAZmHLUwyg4IoLBEes
	3sDNtKTC3FmmC4KuLkFa3zUbChboE/0yApYuWTFEVkvMzuQMT+9zfpDUtwhcIcigoo6J
	zR82+gK9oQSaXNwRlO1eamkQAehb0B9Qie4PQFvefoL5iAkbjNu0l0Y9HNyNuuu/9M2Y
	I2DswIRCzvpKinjHy3qHOWitLKnzTPmpPP1U4XE13GWNv+WP+DpY2Q4X/KSZGZqywpAz
	26L+w9X2DMshsIOl/C77D/feNoLcFl1Wvc3fq/Y9P/l1ok3GQDAqU6vZ3rglsVtm7PIu
	HyRw==
Date: Thu, 18 Jan 2018 16:22:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180118162250.013954dd@xeon-e3>
In-Reply-To: <20180118233745.GA23355@embeddedor.com>
References: <20180118233745.GA23355@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: return boolean instead of integer in
 br_multicast_is_router
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Thu, 18 Jan 2018 17:37:45 -0600
"Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:

> Return statements in functions returning bool should use
> true/false instead of 1/0.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

LGTM

Fixes: 85b352693264 ("bridge: Fix build error when IGMP_SNOOPING is not enabled")
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
