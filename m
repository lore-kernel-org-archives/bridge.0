Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Ta8oz1fbvaerH5A/X0TFTtxjW5L9oeCcWqi65Orht20=;
	b=AgbneLOHwr+ltseE91JSrh6UZVFVTzRe/ObKcZKmqIrirut8VovvSG4418gnuXXCGy
	ElYWnmghul+08oeKp8vMlp56fMXK3BHJ4wiqnY7eKZ38dgtE5JJBjtAsVAJyBIfWBsdj
	ZeJkOR3A5bhTNDJhPdJhnyLRzU1Tr/YQjfoiE=
References: <cover.1527173527.git.petrm@mellanox.com>
	<af1bed5ce2b236544edd591b8cfb8425c2cb5ca0.1527173527.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d5f98461-710b-ef1b-3ae8-71ba428430da@cumulusnetworks.com>
Date: Fri, 25 May 2018 15:04:37 +0300
MIME-Version: 1.0
In-Reply-To: <af1bed5ce2b236544edd591b8cfb8425c2cb5ca0.1527173527.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/7] net: bridge: Extract boilerplate
 around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

On 24/05/18 18:10, Petr Machata wrote:
> A call to switchdev_port_obj_add() or switchdev_port_obj_del() involves
> initializing a struct switchdev_obj_port_vlan, a piece of code that
> repeats on each call site almost verbatim. While in the current codebase
> there is just one duplicated add call, the follow-up patches add more of
> both add and del calls.
> 
> Thus to remove the duplication, extract the repetition into named
> functions and reuse.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

