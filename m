Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:x-mailer:content-transfer-encoding:mime-version;
	bh=Da5NfzlUJ9hijUnZ8NeVGWfTQoAilcpu98wOMoYETEo=;
	b=hwOEsUTqSsl1AqVS8obZ0CY37Ij28O1739PPpKnoJuw+SYHGe2fXa0rzAnJ/bKfNj6
	mTKDzqQrVIc270JSvFarwH6GuAV+UpSG6RYnWoGw9Q5thtjRATaeV0tJDYXXECfrLJHC
	4zOJHJyFWt0E7B55aqgmazJmpfx53BTRIJkEZzuoOd+F85aKxuwAp89ibu1DhzWO8V21
	GsIsarOTb2DplXcLpAqjVRLcA4s3lHHYOi0mGlztlOWb+0P2RMqojtPrfikZAjWBE35G
	lDVQw6rQg6cqUa8depct9I+HGOwWVwbV8LE48bIzE+3mKP+fm9tM7INFBx/VMXePI+zg
	QO5w==
Message-ID: <1371704129.3252.356.camel@edumazet-glaptop>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 19 Jun 2013 21:55:29 -0700
In-Reply-To: <51C2721B.9050603@gmail.com>
References: <51C2710D.2060405@gmail.com> <51C2721B.9050603@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH] net bridge: add null pointer check, fix panic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xiaoming gao <gxm.linux.kernel@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Thu, 2013-06-20 at 11:08 +0800, xiaoming gao wrote:
> From: newtongao <newtongao@tencent.com>
> Date: Wed, 19 Jun 2013 14:58:33 +0800
> Subject: [PATCH] net bridge: add null pointer check,fix panic
> 
> in kernel 3.0, br_port_get_rcu() may return NULL when network interface be deleting from bridge,
> but in function br_handle_frame and br_handle_local_finish, the pointer didn't be checked before using,
> so all br_port_get_rcu callers must do null check,or there occurs the null pointer panic.
> 
> kernel 3.4 also has this bug,i have verified.
> mainline kernel still did not  check br_port_get_rcu()'s NULL pointer, but i have not tested it yet.

Please check current version before sending a patch.

This was most probably fixed in commit 00cfec37484761a44
("net: add a synchronize_net() in netdev_rx_handler_unregister()")

Thanks


