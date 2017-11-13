Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=BEjKNwma9ZOlVgRDG5zl/wRt0HpaDE1yAYKH1NVOzIw=;
	b=IsNCRU9AJJzer0rE3CeQMPurNjuGzvaWrVOlBeW9IsUWFZRQ6J1ZEVAG2tBfD+kMvL
	SvG5WSoIMcW1yxiJSQv8ZQYgh+bEYx4eX2wqiILW9rOcuw1+kLBqmjyHzZo/hV6f3KXz
	WipuEaBfOl7oj/NS1NCjl61ng2nbdoPpDm+9U=
MIME-Version: 1.0
In-Reply-To: <1510590655-20935-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1510590655-20935-1-git-send-email-nikolay@cumulusnetworks.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Mon, 13 Nov 2017 10:04:14 -0800
Message-ID: <CAJieiUi80Zn+2U2fh=ViweaO82JYAR5QQKmi1m53gfSzpQ0u0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH net] net: bridge: add vlan_tunnel to bridge
	port policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Mon, Nov 13, 2017 at 8:30 AM, Nikolay Aleksandrov
<nikolay@cumulusnetworks.com> wrote:
> Found another missing port flag policy entry for IFLA_BRPORT_VLAN_TUNNEL
> so add it now.
>
> CC: Roopa Prabhu <roopa@cumulusnetworks.com>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks Nikolay
