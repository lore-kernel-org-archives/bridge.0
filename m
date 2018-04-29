Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lyqGKdLABwBrPcjbvAWUkkzhRLDVLJozvQ+EjxqVtuA=;
	b=HVFWrqe25Qp5SQes1TWL+G2anWis4bGSp7CgmFTPRQ2DIpK0EwCiUQm9jXsbsq26jc
	vbAopPO8+FGBWr99wu8IfibLd+uuHSjYYduELpamoptoXvK5wj1cQNLWJUlfdxKgVHho
	MxycRI3/9pZTfY7ZrJEshkuD+VH9oFrhI3+Zk=
References: <20180429075613.10832-1-idosch@mellanox.com>
	<20180429075613.10832-2-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2876e03c-2e2e-ab4e-6d93-e6950c34c97f@cumulusnetworks.com>
Date: Sun, 29 Apr 2018 11:12:22 +0300
MIME-Version: 1.0
In-Reply-To: <20180429075613.10832-2-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 1/6] net: bridge: Publish bridge
 accessor functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@mellanox.com, jiri@mellanox.com, mlxsw@mellanox.com, davem@davemloft.net

On 29/04/18 10:56, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> Add a couple new functions to allow querying FDB and vlan settings of a
> bridge.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>   include/linux/if_bridge.h | 28 ++++++++++++++++++++++++++++
>   net/bridge/br_fdb.c       | 22 ++++++++++++++++++++++
>   net/bridge/br_private.h   | 11 +++++++++++
>   net/bridge/br_vlan.c      | 39 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 100 insertions(+)
> 

Looks good,
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


