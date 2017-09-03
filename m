Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=5pdkziv8C4OUPRoz+8pGJ7carC9PIkjC/l5OoCJeYEs=;
	b=H2QQnJsvNTMo0HiN2pJvXJQ3Ze3N25x0QhY4vBB2vrrfbdsBqi+2BLUGZg/RO9T9iU
	rIdWMM6esWYlpsBN+SA+z2IPKgZkZxT7+kPm2FduLG5Svr/A5VVzl4B+qTe/6xiwdu2I
	tx7qVBd9NolfKN8bJoAaSnmLXo8j0CV9mpPYE=
References: <20170903144413.21946-1-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <71444c6f-d33f-3bef-9e1d-d34f7fd333b4@cumulusnetworks.com>
Date: Sun, 3 Sep 2017 18:02:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170903144413.21946-1-idosch@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: switchdev: Use an helper to
 clear forward mark
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, mlxsw@mellanox.com, davem@davemloft.net, yotamg@mellanox.com

On 03/09/17 17:44, Ido Schimmel wrote:
> Instead of using ifdef in the C file.
> 
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Suggested-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Tested-by: Yotam Gigi <yotamg@mellanox.com>
> ---
>  net/bridge/br_device.c  | 4 +---
>  net/bridge/br_private.h | 9 +++++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 

Thanks for following up on this!

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


