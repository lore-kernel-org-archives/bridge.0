Return-Path: <hannes@stressinduktion.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	stressinduktion.org; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=MXsMBdgoCDXj8UQn
	Yk7H5Z71cBE=; b=JmJ83X5KzEZ5xYBN5oQQ9T/u8E5dQjCqua20G/L9y1Iig0aH
	m+Q8oPzWbXeuvSBHdjSSIuyP/aXm/ibc1wxliTZnAoJcxiNfQtII10v8je89igot
	Y5tu9O28OmDghWDHejoo8/esonnyhiMuZGZ5FFqOwl/fbTPcCstBjFVL5n4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MXsMBdgoCDXj8UQ
	nYk7H5Z71cBE=; b=IVKRy8V7hJlL4QWAaNFxI7CyftnhxEZ562ZVeKSeT/mbhbC
	iU3x6lITPqNLazIvsOm5T4eii0y/lQ4rXPSLmz5cwKbVEIhsQkYxXHbPYaduZCcj
	5+tLw67jXVRxLJ+PX79SRHI4mxwWzrmn2yFrQjJVJ3RWyT9O3q86JPxOf5t4=
Message-Id: <1448979224.3359384.454695137.2DC07EE8@webmail.messagingengine.com>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Date: Tue, 01 Dec 2015 15:13:44 +0100
In-Reply-To: <87egf7183c.fsf_-_@x220.int.ebiederm.org>
References: <565B7F7D.80208@nod.at>
	<CAGXu5jJqQKAmFK0nL69E0QOpo8WSVDqStGZo7-m7gy3vnXBa=A@mail.gmail.com>
	<87egf7183c.fsf_-_@x220.int.ebiederm.org>
Subject: Re: [Bridge] [PATCH net] bridge: Only call /sbin/bridge-stp for the
 initial network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Eric W. Biederman" <ebiederm@xmission.com>, David Miller <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com, Richard Weinberger <richard@nod.at>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

On Mon, Nov 30, 2015, at 22:38, Eric W. Biederman wrote:
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  net/bridge/br_stp_if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 5396ff08af32..742fa89528ab 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -142,7 +142,9 @@ static void br_stp_start(struct net_bridge *br)
>  	char *envp[] = { NULL };
>  	struct net_bridge_port *p;
>  
> -       r = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);
> +       r = -ENOENT;
> +       if (dev_net(br->dev) == &init_net)

net_eq ?

> +               r = call_usermodehelper(BR_STP_PROG, argv, envp,
> UMH_WAIT_PROC);
>  
>  	spin_lock_bh(&br->lock);
>  

Otherwise, ack, so far.

As our /sys interfaces directories are tagged by the net namespace it
would actually make sense to run bridge-stp automatically in another
name space.

Bye,
Hannes
