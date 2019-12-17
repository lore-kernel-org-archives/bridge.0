Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zavmadytOudz+T/44TMehrS1o8s5e7V8+sU0tqu6M4c=;
 b=Yl7D+tzuSlv3bMSHN1THeOZpm5RuHPGIUT5A+Mjl4CPSZwQ6ua617xnIshk5Dw8Hx8
 kbDay2N4bvLjAKcFt2ulsel5x+3yUPIt9ITwQ5N8Pwk+RGXR0XXHh2rnEcRy1BSgMCxU
 nXIw7E+SE9BT/VU/+Z6e8pCM9mIYdRvivLeccH+1wCViROooPjk0an4vwDrJ9tPdtC8U
 iPk2nKAr5aDhaEWhXF3n16ptBDFq8Vxd2+Nfn5jfIfBh7OGC+yVYJiqE7oMjVYbjFVC2
 mmAFYS9QhszLi0RmO76zJaQG9YgKzWc9eTFpHeH211ngK6FItCs6vHu9iee6iQRpN7K5
 mA4w==
Date: Mon, 16 Dec 2019 20:45:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20191216204541.0540deb2@hermes.lan>
In-Reply-To: <20191212010711.1664000-2-vivien.didelot@gmail.com>
References: <20191212010711.1664000-1-vivien.didelot@gmail.com>
 <20191212010711.1664000-2-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2 v4] iplink: add support for STP xstats
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

On Wed, 11 Dec 2019 20:07:11 -0500
Vivien Didelot <vivien.didelot@gmail.com> wrote:

> Add support for the BRIDGE_XSTATS_STP xstats, as follow:
> 
>     # ip link xstats type bridge_slave dev lan4 stp
>     lan4
>                         STP BPDU:  RX: 0 TX: 61
>                         STP TCN:   RX: 0 TX: 0
>                         STP Transitions: Blocked: 2 Forwarding: 1
> 
> Or below as JSON:
> 
>     # ip -j -p link xstats type bridge_slave dev lan0 stp
>     [ {
>             "ifname": "lan0",
>             "stp": {
>                 "rx_bpdu": 0,
>                 "tx_bpdu": 500,
>                 "rx_tcn": 0,
>                 "tx_tcn": 0,
>                 "transition_blk": 0,
>                 "transition_fwd": 0
>             }
>         } ]
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

This patch depends on new kernel features, should be to iproute2-next
