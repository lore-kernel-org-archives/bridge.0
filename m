Return-Path: <jakub.kicinski@netronome.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=xY694KnXGlHwEnM5IxCeasI3CBIwUmkENhRchcSKqBs=;
 b=jQMDnKdtj5UjOtGBLN76SKHmmIcQU5b7bnWPN53p7CZ/WbEMVXW3UZXOvkSbd2mXpP
 yKgn65PesyrI4h+gkOOiJ10S0fJBYKYSakWrCTvb7D3QWmQQ3kdNyHO1O7oLeXQKh7m9
 muFlUcabl/xplTzsi9cevgdgRsTiIbHrhk9xAoIkQe3RBcnl4GH3JBjBc5y7Ga3Bmz8c
 kfCOckUKF3mctdIZ1/wwZUS7SiRs1JyF4f8rfiD2i8Lw5wbOyipxvr0hwskmRdDAeW+c
 lvejhZciw3hsja6TWiDD6R2R+r4f/ThG6xjohlwoBEi47ZPXKJjxA2BsrRjKsD0l3LAM
 OaWA==
Date: Sat, 14 Dec 2019 20:03:32 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Message-ID: <20191214200332.1c4d414f@cakuba.netronome.com>
In-Reply-To: <20191212010711.1664000-1-vivien.didelot@gmail.com>
References: <20191212010711.1664000-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, "David S. Miller" <davem@davemloft.net>

On Wed, 11 Dec 2019 20:07:10 -0500, Vivien Didelot wrote:
> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
> transition_fwd xstats counters to the bridge ports copied over via
> netlink, providing useful information for STP.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

Applied, thank you!
