Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=TXhOWjZ5g5tZ+IU61JF86RWzhL6BGUhDwmK/oiO6TCI=;
	b=bsSs+d+uRPqoGOEIYb4DrrY3J0l1TIZPEaf/Uz9PgIQcwDHBrZl2Z2qvmTd6CdDlah
	u8CQ259P5kB63On5upVecF7My+OUvZUNBaQySAOd+cmSNLCkAjC97QLvxV8cSocER9Q0
	yjj3xr5GFx/2N+2cAYdMabGAMIJ+R1FpLrue8=
References: <cover.1527641426.git.petrm@mellanox.com>
	<7b6f3bdc759168227bbff78173837d5fb5560528.1527641426.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <dfd84f5f-bcb8-c301-7c52-818150af69fd@cumulusnetworks.com>
Date: Wed, 30 May 2018 18:12:02 +0300
MIME-Version: 1.0
In-Reply-To: <7b6f3bdc759168227bbff78173837d5fb5560528.1527641426.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 1/8] net: bridge: Extract
 boilerplate around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

On 30/05/18 03:56, Petr Machata wrote:
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
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>  net/bridge/br_private.h   | 13 +++++++++++++
>  net/bridge/br_switchdev.c | 25 +++++++++++++++++++++++++
>  net/bridge/br_vlan.c      | 26 +++-----------------------
>  3 files changed, 41 insertions(+), 23 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


